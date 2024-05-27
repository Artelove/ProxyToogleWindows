# Proxy Toggle Script

This script toggles the proxy settings on your Windows machine. It checks the current state of the proxy (enabled or disabled) and switches it to the opposite state. This can be useful for quickly enabling or disabling a proxy server for testing or other purposes.

## How It Works

1. **Setting Variables:**
    - `proxyAddress`: IP address of the proxy server.
    - `proxyPort`: Port number of the proxy server.
    - `proxyExceptions`: A list of sites that should bypass the proxy.

2. **Getting Current Proxy Status:**
    - The script queries the Windows registry to determine if the proxy is currently enabled or disabled.

3. **Toggling Proxy State:**
    - If the proxy is currently disabled (`ProxyStatus` is 0), the script will enable it.
    - If the proxy is currently enabled (`ProxyStatus` is 1), the script will disable it.

4. **Registry Modifications:**
    - When enabling the proxy, it updates the registry with the proxy server address and port.
    - It also sets the exceptions list for sites that should not use the proxy.
    - When disabling the proxy, it updates the registry to disable the proxy and resets the proxy settings using `netsh`.

## How to Use

1. **Configure the Script:**
    - Open the script in a text editor.
    - Replace `YOUR.PROXY.IP` with the IP address of your proxy server.
    - Replace `YOUR.PORT` with the port number of your proxy server.
    - Modify the `proxyExceptions` variable if you need to add or remove sites from the exceptions list.

2. **Run the Script:**
    - Save the script with a `.bat` extension (e.g., `toggle_proxy.bat`).
    - Run the script by double-clicking the `.bat` file or executing it from the command line.

3. **Check the Output:**
    - The script will display the current proxy status and indicate whether it is enabling or disabling the proxy.

## Example

To enable a proxy server with the IP address `192.168.1.100` and port `8080`, and to exclude `localhost`, `127.0.0.1`, and `www.youtube.com` from using the proxy, configure the script as follows:

```batch
set proxyAddress=192.168.1.100
set proxyPort=8080
set proxyExceptions=*.local;127.0.0.1;www.youtube.com
```
## Notes
- Administrator privileges may be required to modify the registry and proxy settings.
- The script is designed for Windows systems and may not work on other operating systems.
