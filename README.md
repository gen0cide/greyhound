# Greyhound

![Greyhound](http://static7.businessinsider.com/image/4f0c4905eab8ea096c000037-398-298/greyhound.jpg)

## Overview

**Greyhound**, a scalable blob storage engine. Similar to Memcached and Redis, but much better. 

####Reasons why Greyhound is better:

* Compatible with almost any linux system.
* Easy to add extensions
* Near real time persistance
* Atomic
* JSON compatible

## Usage

To start the server:

```
$ git clone https://github.com/gen0cide-/greyhound.git
$ cd greyhound
$ ./server.sh -p 12345
```
From there, you can now interface with it via some basic commands using the `nc` client.

```
$ nc $IP_OF_GREYHOUND_SERVER 12345
SET foo bar
OK
GET foo
bar
```

## Roadmap

We want to add the following features (feel free to contribute pull requests):

* Administrative Console
* Statistics (statsd?)
* HTTP Support
* Authentication

## Acknowledgements

Shoutouts:

* maus_
* Vyrus
* Kimjongilla

## License

Copyright (C) 2013 Alex Levinson

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see http://www.gnu.org/licenses/

## Contact

Twitter: @alexlevinson


