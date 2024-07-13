# 🚗 FiveM Vehicle Scrapping Script

## 📜 Overview

This FiveM script enhances the roleplaying experience by allowing players to scrap their vehicles directly in-game. Key features include:

- 🎮 **In-Game Interaction**: Players can access a user-friendly menu to view and select vehicles for scrapping, all within the game environment.
- 💾 **Database Integration**: When a vehicle is scrapped, it's permanently removed from the server's database, ensuring a realistic and persistent world.
- 💰 **Economic Impact**: Players receive a configurable amount of money for scrapping their vehicles, adding an economic element to the decision.
- 🔒 **Secure Process**: The script includes verification checks to ensure only the vehicle owner can scrap their vehicles.
- 📊 **Logging System**: All scrapping activities are logged via Discord webhook, allowing server administrators to monitor usage and prevent abuse.
- 🌐 **Multi-language Support**: Easily switch between languages or add new ones to cater to diverse player bases.

This script seamlessly integrates with the ESX framework, providing a smooth and immersive experience for both players and server administrators. Whether managing vehicle inventory, roleplaying as a scrap dealer, or implementing server-wide economic policies, this tool offers a flexible and robust solution for vehicle management in FiveM servers.


![Vehicle Scrapping]([https://i.imgur.com/vehiclescrapping.png](https://i.imgur.com/q7ys4Xi.png))


## ✨ Features

- 🚙 Display all vehicles owned by the player
- 💰 Configurable scrapping costs
- 🌐 Multi-language support (currently English and German)
- 📊 Discord webhook for logging and monitoring
- 👥 Optional display of vehicle jobs
- 🛠 Easily configurable via `config.lua`

## 📋 Prerequisites

- FiveM Server
- ESX Framework
- oxmysql
- ox_lib

## 🚀 Installation

1. Download the script and extract it into your `resources` folder.
2. Add `j_vehiclescrapping` (or the name of your resource folder) to your `server.cfg`.
3. Configure the `config.lua` to your liking.
4. Restart your FiveM server.

## ⚙️ Configuration

Open `config.lua` to adjust the following settings:

- Discord Webhook URL
- Scrapping costs
- Language
- Job display in menu
- and more...

## 🖥️ Usage

Players can use the `/myvehicles` command to open the scrapping menu.

## 🌍 Multi-language Support

The script currently supports English and German. You can easily add more languages in the `config.lua`.

## 🚫 Not Included

Please note that this script does not include:

- A vehicle key system
- Custom notification scripts

## 🤝 Contributing

Contributions are welcome! Please fork the project and submit a pull request.

## 📜 License

This project is licensed under the [MIT License](LICENSE).

## 🙏 Acknowledgements

- Thanks to the ESX community for the great framework.
- Special thanks to Anthropic's Claude AI for assistance in development.

## 📞 Support

If you have any questions or issues, please open an issue on GitHub or contact me via discord [e1nfachjustin].

---

Developed with ❤️
