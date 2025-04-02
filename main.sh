#!/bin/bash

# For error handling
set -e

declare -A user_emails=(
    ["jethalal"]="jethalal81815@gmail.com"
    ["babita"]="babitaji81815@gmail.com"
    ["gulabo"]="gulabo81815@gmail.com"
)

# Log file path
LOG_FILE="/var/log/password_change.log"

generate_password() {
    openssl rand -base64 12 | tr -dc 'A-Z0-9a-z' | head -c 8
}

# Email subject
subject="Your New Password"

echo -e ">>>> On date: $(date)" >> "$LOG_FILE"

for user in "${!user_emails[@]}"; do

    # Generate password
    new_password=$(generate_password)
    
    # Email body 
    email_body="Hello $user,\n\nYour password has been changed. \nYour new password is: $new_password\n\nBest regards,\nYour IT Team"
    
    # User's password change
    echo "$user:$new_password" | sudo chpasswd

    # Check if password change successfully or not
    if [ $? -eq 0 ]; then
        echo -e "✅ Password changed for $user \n🔑 Password: ($new_password)" >> "$LOG_FILE"
    else
        echo "❌ Failed to change password for $user" >> "$LOG_FILE"
        continue
    fi


    # User's email address
    recipient_email_address="${user_emails[$user]}"

    # Format the email body
    formatted_email_body=$(printf "$email_body" "$new_password")

    # Sending the email
    echo -e "$formatted_email_body" | mail -s "$subject" "$recipient_email_address"

    # Check if email was sent successfully or not
    if [ $? -eq 0 ]; then
        echo -e "📧 Email sent to $user \n" >> "$LOG_FILE"
    else
        echo -e "⚠️ Failed to send email to $user \n" >> "$LOG_FILE"
    fi
done

echo -e "Password change and email notification completed.\n\n" >> "/var/log/password_change.log"
