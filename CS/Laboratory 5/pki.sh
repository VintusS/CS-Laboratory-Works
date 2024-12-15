#!/usr/bin/env bash

CWD="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$CWD/pki"
CA_DIR="$BASE_DIR/ca"
USERS_DIR="$BASE_DIR/users"
CERTS_DIR="$BASE_DIR/certs"
CRL_DIR="$BASE_DIR/crl"

validate_non_empty() {
    if [ -z "$1" ]; then
        echo "[ERROR] $2 cannot be empty."
        return 1
    fi
    return 0
}

validate_length() {
    if [ ${#1} -ne "$2" ]; then
        echo "[ERROR] $3 must be $2 characters."
        return 1
    fi
    return 0
}

validate_email() {
    if ! [[ "$1" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        echo "[ERROR] Invalid email address."
        return 1
    fi
    return 0
}

get_input() {
    read -p "$1: " INPUT
    echo "$INPUT"
}

initialize_pki() {
    echo "Initializing PKI..."
    mkdir -p "$CA_DIR" "$USERS_DIR" "$CERTS_DIR" "$CRL_DIR"
    chmod -R 777 "$BASE_DIR"

    echo "Generating CA private key (4096 bits)..."
    openssl genrsa -out "$CA_DIR/ca.key" 4096

    echo "Creating self-signed CA certificate (10 years)..."
    country="$(get_input 'Enter Country (2 letters)')"
    if ! validate_length "$country" 2 "Country"; then return; fi
    state="$(get_input 'Enter State/Region')"
    if ! validate_non_empty "$state" "State/Region"; then return; fi
    city="$(get_input 'Enter City')"
    if ! validate_non_empty "$city" "City"; then return; fi
    organization="$(get_input 'Enter Organization')"
    if ! validate_non_empty "$organization" "Organization"; then return; fi
    organization_unit="$(get_input 'Enter Organizational Unit')"
    if ! validate_non_empty "$organization_unit" "Organizational Unit"; then return; fi
    name="$(get_input 'Enter Name')"
    if ! validate_non_empty "$name" "Name"; then return; fi
    email_address="$(get_input 'Enter Email Address')"
    if ! validate_non_empty "$email_address" "Email Address"; then return; fi

    openssl req -new -x509 -days 3650 -key "$CA_DIR/ca.key" \
        -out "$CA_DIR/ca.crt" \
        -subj "/C=$country/ST=$state/L=$city/O=$organization/OU=$organization_unit/CN=$name/emailAddress=$email_address"

    touch "$CA_DIR/index.txt"
    echo 1000 > "$CA_DIR/serial"
    echo 1000 > "$CA_DIR/crlnumber"

    echo "Generating initial CRL..."
    openssl ca -gencrl -out "$CRL_DIR/ca.crl" -config <(cat <<-EOF
[ ca ]
default_ca = CA_default

[ CA_default ]
default_md = sha256
certs = $CERTS_DIR
new_certs_dir = $CERTS_DIR
database = $CA_DIR/index.txt
serial = $CA_DIR/serial
private_key = $CA_DIR/ca.key
certificate = $CA_DIR/ca.crt
crl_dir = $CRL_DIR
crlnumber = $CA_DIR/crlnumber
default_crl_days = 30
unique_subject = no
policy = policy_any

[ policy_any ]
countryName = optional
stateOrProvinceName = optional
organizationName = optional
organizationalUnitName = optional
commonName = supplied
emailAddress = optional
EOF
    )
    echo "Initial CRL generated successfully."
    echo "PKI initialized successfully."

}

create_user() {
     USER_NAME="$(get_input 'Enter username')"
    USER_DIR="$USERS_DIR/$USER_NAME"

    # Check if user already exists
    if [ -d "$USER_DIR" ]; then
        echo "User $USER_NAME already exists."
        return
    fi

    mkdir -p "$USER_DIR"
    chmod -R 777 "$USER_DIR"

    echo "Generating private key for $USER_NAME (2048 bits)..."
    openssl genrsa -out "$USER_DIR/$USER_NAME.key" 2048

    echo "Creating certificate signing request for $USER_NAME..."

    # Collect inputs with validation
    country="$(get_input 'Enter Country (2 letters)')"
    if ! validate_length "$country" 2 "Country"; then return; fi

    state="$(get_input 'Enter State')"
    if ! validate_non_empty "$state" "State"; then return; fi

    city="$(get_input 'Enter Locality')"
    if ! validate_non_empty "$city" "Locality"; then return; fi

    organization="$(get_input 'Enter Organization')"
    if ! validate_non_empty "$organization" "Organization"; then return; fi

    organization_unit="$(get_input 'Enter Organizational Unit')"
    if ! validate_non_empty "$organization_unit" "Organizational Unit"; then return; fi

    name="$(get_input 'Enter Common Name')"
    if ! validate_non_empty "$name" "Common Name"; then return; fi

    email_address="$(get_input 'Enter Email Address')"
    if ! validate_non_empty "$email_address" "Email Address"; then return; fi
    if ! validate_email "$email_address"; then return; fi

    openssl req -new -key "$USER_DIR/$USER_NAME.key" \
        -out "$USER_DIR/$USER_NAME.csr" \
        -subj "/C=$country/ST=$state/L=$city/O=$organization/OU=$organization_unit/CN=$name/emailAddress=$email_address"

    echo "Signing user certificate with CA..."
    openssl ca -batch -days 365 -in "$USER_DIR/$USER_NAME.csr" \
        -out "$USER_DIR/$USER_NAME.crt" -cert "$CA_DIR/ca.crt" -keyfile "$CA_DIR/ca.key" \
        -config <(cat <<-EOF
[ ca ]
default_ca = CA_default

[ CA_default ]
default_md = sha256
certs = $CERTS_DIR
new_certs_dir = $CERTS_DIR
database = $CA_DIR/index.txt
serial = $CA_DIR/serial
private_key = $CA_DIR/ca.key
certificate = $CA_DIR/ca.crt
crl_dir = $CRL_DIR
crlnumber = $CA_DIR/crlnumber
default_crl_days = 30
unique_subject = no
policy = policy_any

[ policy_any ]
countryName = optional
stateOrProvinceName = optional
organizationName = optional
organizationalUnitName = optional
commonName = supplied
emailAddress = optional
EOF
)

    cp "$USER_DIR/$USER_NAME.crt" "$CERTS_DIR/$USER_NAME.crt"
    echo "User $USER_NAME created successfully."
}

revoke_user() {
    USER_NAME="$(get_input 'Enter username to revoke')"
    USER_DIR="$USERS_DIR/$USER_NAME"

    if [ ! -f "$USER_DIR/$USER_NAME.crt" ]; then
        echo "Certificate for $USER_NAME does not exist."
        return
    fi

    echo "Revoking certificate for $USER_NAME..."
    openssl ca -revoke "$USER_DIR/$USER_NAME.crt" -keyfile "$CA_DIR/ca.key" -cert "$CA_DIR/ca.crt" \
    -config <(cat <<-EOF
[ ca ]
default_ca = CA_default

[ CA_default ]
default_md = sha256
certs = $CERTS_DIR
new_certs_dir = $CERTS_DIR
database = $CA_DIR/index.txt
serial = $CA_DIR/serial
private_key = $CA_DIR/ca.key
certificate = $CA_DIR/ca.crt
crl_dir = $CRL_DIR
crlnumber = $CA_DIR/crlnumber
default_crl_days = 30
unique_subject = no
policy = policy_any

[ policy_any ]
countryName = optional
stateOrProvinceName = optional
organizationName = optional
organizationalUnitName = optional
commonName = supplied
emailAddress = optional
EOF
)

    echo "Generating CRL..."
    openssl ca -gencrl -out "$CRL_DIR/ca.crl" -config <(cat <<-EOF
[ ca ]
default_ca = CA_default

[ CA_default ]
default_md = sha256
certs = $CERTS_DIR
new_certs_dir = $CERTS_DIR
database = $CA_DIR/index.txt
serial = $CA_DIR/serial
private_key = $CA_DIR/ca.key
certificate = $CA_DIR/ca.crt
crl_dir = $CRL_DIR
crlnumber = $CA_DIR/crlnumber
default_crl_days = 30
unique_subject = no
policy = policy_any

[ policy_any ]
countryName = optional
stateOrProvinceName = optional
organizationName = optional
organizationalUnitName = optional
commonName = supplied
emailAddress = optional
EOF
)

    echo "Certificate for $USER_NAME revoked."
}

list_users() {
    echo "Existing users:"
    ls "$USERS_DIR"
}

delete_user() {
    USER_NAME="$(get_input 'Enter username to delete')"
    USER_DIR="$USERS_DIR/$USER_NAME"

    if [ ! -d "$USER_DIR" ]; then
        echo "User $USER_NAME does not exist."
        return
    fi

    rm -rf "$USER_DIR"
    rm -f "$CERTS_DIR/$USER_NAME.crt"
    echo "User $USER_NAME deleted successfully."
}

sign_file() {
    USER_NAME="$(get_input 'Enter username to sign with')"
    USER_DIR="$USERS_DIR/$USER_NAME"
    FILE="$(get_input 'Enter file to sign')"
    SIGNATURE="$FILE.sig"

    if [ ! -f "$USER_DIR/$USER_NAME.key" ]; then
        echo "Private key for $USER_NAME not found."
        return
    fi

    if [ ! -f "$USER_DIR/$USER_NAME.crt" ]; then
        echo "Certificate for $USER_NAME not found."
        return
    fi

    if [ ! -f "$FILE" ]; then
        echo "File $FILE not found."
        return
    fi

    if [ -f "$SIGNATURE" ]; then
        echo "Signature file $SIGNATURE already exists."
        return
    fi

    if ! openssl verify -CAfile "$CA_DIR/ca.crt" -crl_check -CRLfile "$CRL_DIR/ca.crl" "$USER_DIR/$USER_NAME.crt"; then
        echo "Cannot sign. Certificate for $USER_NAME is invalid or revoked."
        return
    fi
    openssl dgst -sha256 -sign "$USER_DIR/$USER_NAME.key" -out "$SIGNATURE" "$FILE"

    echo "File signed. Signature saved as $SIGNATURE."
}

verify_signature() {
    FILE="$(get_input 'Enter file to verify')"
    SIGNATURE="$FILE.sig"
    USER_NAME="$(get_input 'Enter username to verify against')"
    USER_DIR="$USERS_DIR/$USER_NAME"

    if [ ! -f "$USER_DIR/$USER_NAME.crt" ]; then
        echo "Certificate for $USER_NAME not found."
        return
    fi

    if [ ! -f "$SIGNATURE" ]; then
        echo "Signature file $SIGNATURE not found."
        return
    fi

    if [ ! -f "$FILE" ]; then
        echo "File $FILE not found."
        return
    fi

    if [ ! -f "$CA_DIR/ca.crt" ]; then
        echo "CA certificate not found."
        return
    fi


    if ! openssl verify -CAfile "$CA_DIR/ca.crt" -crl_check -CRLfile "$CRL_DIR/ca.crl" "$USER_DIR/$USER_NAME.crt"; then
        echo "Certificate for $USER_NAME is invalid or revoked."
        return
    fi

    openssl dgst -sha256 -verify <(openssl x509 -in "$USER_DIR/$USER_NAME.crt" -pubkey -noout) \
        -signature "$SIGNATURE" "$FILE"
    echo "Verification complete."
}

while true; do
    echo "PKI Management System"
    echo "1. Initialize PKI"
    echo "2. Create User"
    echo "3. Revoke User"
    echo "4. List Users"
    echo "5. Delete User"
    echo "6. Sign File"
    echo "7. Verify Signature"
    echo "8. Exit"

    read -p "Choose an option: " OPTION

    case $OPTION in
        1) initialize_pki ;;
        2) create_user ;;
        3) revoke_user ;;
        4) list_users ;;
        5) delete_user ;;
        6) sign_file ;;
        7) verify_signature ;;
        8) exit        ;;
        *) echo "Invalid option, please try again." ;;
    esac

done