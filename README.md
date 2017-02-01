Automatize your tasks and run cron jobs for robots written in Python 3. Isolated, with all dependencies, in Docker container.

## Usage
Well, first start with robots itself. If you need some extra packages, just create `requirements.txt` in root of your "robots" directory and put them here, for example:

```
feedparser==5.2.1
slackclient==1.0.2
```

Another important file is `crontab`, in same directory as requirements.txt. Use full path for Python 3.5 and note that your robots will be stored in `/robots` directory in running container. If you want to see output of your robots, log it into `/var/log/robots.log` file:

```
* * * * * /usr/bin/python3.5 /robots/my_robot.py >> /var/log/robots.log 2>&1
```

`robots.log` will also be outputed into container logs (accessible via `docker logs [id]`).

To run initialization script before all robots, create file `_init.py` and put your code there.

To run container, just mount directory with your robots into `/robots` in container:

```
docker run -itd --name robots -v /var/robots/:/robots pavelsterba/python-robots
```

It will install all dependencies from `requirements.txt` and setup cron jobs from `crontab`. To add new job or update crontab, you have to stop & delete current container and run new one (will be most likely fixed in upcoming version).
