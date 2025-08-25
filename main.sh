#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Declare associative array for users and their email addresses
declare -A user_emails=(
    ["jethalal"]="jethalal81815@gmail.com"
    ["babita"]="babitaji81815@gmail.com"
    ["gulabo"]="gulabo81815@gmail.com"
    # Add users as per need
)

# Path to the log file
LOG_FILE="/var/log/password_change.log"

# Function to generate a random password
generate_password() {
    openssl rand -base64 12 | tr -dc 'A-Z0-9a-z' | head -c 8
}

# Subject for the email notification
subject="Your New Password"

# Log the date of operation
echo -e ">>>> On date: $(date)" >> "$LOG_FILE"

# Loop through each user in the array
for user in "${!user_emails[@]}"; do

    # Generate a new password for the user
    new_password=$(generate_password)
    
    # Prepare the email body with the new password
    email_body="Hello $user,\n\nYour password has been changed. \nYour new password is: $new_password\n\nBest regards,\nYour IT Team"
    
    # Change the user's password using chpasswd
    echo "$user:$new_password" | sudo chpasswd

    # Check if password change was successful
    if [ $? -eq 0 ]; then
        echo -e "✅ Password changed for $user \n🔑 Password: ($new_password)" >> "$LOG_FILE"
    else
        echo "❌ Failed to change password for $user" >> "$LOG_FILE"
        continue
    fi

    # Get the user's email address from the array
    recipient_email_address="${user_emails[$user]}"

    # Format the email body (not strictly needed here, but kept for clarity)
    formatted_email_body=$(printf "$email_body" "$new_password")

    # Send the email with the new password
    echo -e "$formatted_email_body" | mail -s "$subject" "$recipient_email_address"

    # Check if email was sent successfully
    if [ $? -eq 0 ]; then
        echo -e "📧 Email sent to $user \n" >> "$LOG_FILE"
    else
        echo -e "⚠️ Failed to send email to $user \n" >> "$LOG_FILE"
    fi
done

# Log completion of the process
echo -e "Password change and email notification completed.\n\n" >> "/var/log/password_change.log"