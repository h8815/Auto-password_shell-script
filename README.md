# 🚀 Automated User Password Rotation & Email Notification

## 📌 Overview
This Shell Script automatically resets Linux user passwords daily and sends the new password to their email. It enhances security and automation in user management, especially for DevOps teams.

---

## 🔥 Features
- 🔑 **Generates** strong random 8-character passwords using OpenSSL.
- 🔄 **Changes and updates** user passwords securely via the `chpasswd` command.
- 📧 **Sends an email** notification to users with their new password.
- ⏰ **Automates daily execution** using cron jobs.
- 📝 **Logs all activities** to `/var/log/password_change.log`.

---

## ✅ Prerequisites
Before running this script, ensure you have:

1. A **Linux server** (Ubuntu, CentOS, etc.)
2. **Postfix SMTP Server** installed and configured.
3. **OpenSSL** installed (for password generation)
4. **Mailutils** installed (for sending emails)
5. The script must be run with **sudo privileges**.

### 📌 Install Required Packages:
```sh
sudo apt update && sudo apt install mailutils -y  # For Debian/Ubuntu
sudo yum install mailx -y  # For RHEL/CentOS
```

---

## 🛠️ How to Use

### 1️⃣ Clone the Repository
```sh
git clone https://github.com/h8815/Auto-password_shell-script.git 
cd Auto-password_shell-script
```

### 2️⃣ Modify the User List & Email Domain
```sh
# Define users and their email addresses
declare -A user_emails=(
    ["user1"]="user1@yourcompany.com"
    ["user2"]="user2@yourcompany.com"
)
```

### 3️⃣ Run the Script Manually (For Testing)
```sh
chmod +x main.sh
sudo ./main.sh
```

### 4️⃣ Automate with Cron Job (Daily Execution)
1. Open the crontab editor:
   ```sh
   sudo crontab -e
   ```
2. Add the following line to schedule the script to run daily at midnight:
   ```sh
   0 0 * * * /path/to/main.sh
   ```
3. List or delete cron jobs (if needed):
   ```sh
   sudo crontab -l  # List all cron jobs
   sudo crontab -r  # Remove all cron jobs
   ```

---

## 📜 Logging
1. 📝 All operations, including password changes and email notifications, are logged in:
   ```sh
   cat /var/log/password_change.log
   ```
2. 📌 Logs include timestamps, status messages, and error handling details.

---

## 🛠 Troubleshooting

### ⚠️ Common Issues & Fixes
1. **Ensure the script has execute permissions:**
   ```sh
   chmod +x main.sh
   ```
2. **If emails are not sent:**
   - 🔍 Check if Postfix is installed and running:
     ```sh
     sudo systemctl status postfix
     ```
   - 📨 Verify mail logs:
     ```sh
     cat /var/log/mail.log
     ```
3. **Check cron job logs:**
   ```sh
   grep CRON /var/log/syslog
   ```

---

## 🔒 Security Considerations
- 🔐 Store the script in a secure location with restricted access.
- 🚨 Ensure email notifications do not expose passwords insecurely.

---

## 📜 License

This project is licensed under the **MIT License**.

---

## 📩 Contributions **& Feedback**

Feel free to **fork**, **star**, and **contribute**! If you have suggestions, open an issue or reach out.

🔗 **GitHub Repo:** [https://github.com/h8815/auto-password-shell-script.git](https://github.com/h8815/auto-password-shell-script.git)

---

## 🔗 Connect with Me
<a href="https://www.linkedin.com/in/himanshu-solanki81815" target="_blank">
  <img src="https://raw.githubusercontent.com/rahuldkjain/github-profile-readme-generator/master/src/images/icons/Social/linked-in-alt.svg" alt="LinkedIn" width="24" height="24"/>
</a>

---

## 🛠 Languages and Tools
<p align="left"> 
  <a href="https://www.gnu.org/software/bash/" target="_blank"> 
    <img src="https://www.vectorlogo.zone/logos/gnu_bash/gnu_bash-icon.svg" alt="Bash" width="40" height="40"/> 
  </a> 
  <a href="https://www.linux.org/" target="_blank"> 
    <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/linux/linux-original.svg" alt="Linux" width="40" height="40"/> 
  </a> 
</p>

---
### ✨ **Made with ❤️ for Secure DevOps Management**



