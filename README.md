# Space Engineers on Linux
Docker container for running a Space Engineers server on a Linux machine.

## Requirements
- Debian 8 (to use these files as-is)
- docker (this one is obvious)
- systemd (you can use System V init, but you will have to write your own startup script).

## Setup
Perform the following steps in the written order.

- Create a new system user account which will own the container. The files in this repository assumes that the new user is named `saiban`. You can of course change this to whatever you prefer. Please note that the user ID must correspond to the ID specified in the Dockerfile. If you change it here, you should change it there.

```bash
adduser --system --home /home/saiban --uid 256 --group --gecos "Space Engineers" saiban
```

- Change to the new user by issuing the following command.

```bash
sudo -u saiban /bin/bash
 ```
- Create the required directory structure.

```bash
mkdir -p games/space-engineers/{docker,data}
mkdir -p games/space-engineers/data/Space\ Engineers/{Mods,Saves}
```

- Clone this repository into the home directory of the new user account.

```bash
git clone git@github.com:marjacob/se-server.git games/space-engineers/docker
```

- Obtain a copy of the most current `DedicatedServer.zip` and place it in `~/games/space-engineers/data`. You will usually find it in `[...]\SteamApps\SpaceEngineers\Tools\DedicatedServer.zip` (do not extract its contents).

- Upload your `SpaceEngineers-Dedicated.cfg` and place it in the same folder as `DedicatedServer.zip`. Use the one in this repository and edit it to your liking if you do not already have one.

- Copy `space-engineers.service` from this repository to `/etc/systemd/system`. Do not forget to change the `User` and `Group` setting in this file if you did not go with the defaults.

```bash
sudo cp games/space-engineers/docker/space-engineers.service /etc/systemd/system
```

- **Build the image!**

This will take a while.

```bash
games/space-engineers/docker/build.sh
```

## Updating
Update Space Engineers by replacing the `DedicatedServer.zip` by an updated version and restarting the server.

## Managing the server

### Starting the server

```bash
sudo systemctl start space-engineers
```

### Stopping the server

```bash
sudo systemctl stop space-engineers
```

### Monitoring the server
This will give you live output from the server, as if it was running locally in your terminal.

```bash
sudo journalctl --no-tail -f -u space-engineeers
```

## Additional notes
Running Space Engineers this way requires a helper program called `sigmap` which I developed for this use specifically. It is cloned and built by the Dockerfile and should not add any additional overhead. Because Space Engineers ignores `SIGTERM` which is sent by Docker to shut down the service, `sigmap` catches that signal and forwards `SIGINT` to Space Engineers.

See `https://github.com/marjacob/sigmap` for more information.
