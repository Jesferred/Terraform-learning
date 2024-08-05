#!/bin/bash
apt update 
apt install -y apache2

cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Terraform</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #3C3C3D;
            color: #FFFFFF;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }
        header {
            text-align: center;
            margin-bottom: 20px;
        }
        h1 {
            font-size: 2.5em;
            color: #844FBA;
        }
        p {
            font-size: 1.2em;
            max-width: 600px;
            text-align: center;
        }
        .content {
            background-color: #4C4C4E;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .footer {
            margin-top: 20px;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
    <header>
        <h1>Terraform</h1>
    </header>
    <div class="content">
        <p>Эта страница сделана с помощью Terraform.</p>
        <p>Terraform - это инструмент для создания, изменения и управления инфраструктурой безопасным и предсказуемым способом. Он позволяет определять инфраструктуру как код и использовать декларативные конфигурационные файлы для управления версией и развертыванием.</p>
    </div>
    <footer class="footer">
        &copy; 2024 Terraform Enthusiast v3.0
    </footer>
</body>
</html>

EOF

sudo systemctl restart apache2
sudo systemctl enable apache2
