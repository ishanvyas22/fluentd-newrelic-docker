# Log monitoring using Fluentd and New Relic

## Usage

1. Build docker image:
	```bash
	docker build -t fluentd-newrelic .
	```

1. Replace `<YOUR_LICENSE_KEY>` with your [New Relic License key](https://docs.newrelic.com/docs/apis/intro-apis/new-relic-api-keys/) in `conf/fluent.conf` file.

1. Spin up fluentd docker container:
	```bash
	docker run -it -p 24224:24224 -v $(pwd)/conf:/fluentd/etc fluentd-newrelic
	```

	Above command will start fluentd server. Let it run in background so it can listen to docker container logs.

1. To collect logs from docker container, you'd have to specify log driver to `fluentd` while running docker container:
	```bash
	docker run --log-driver=fluentd --log-opt fluentd-address=localhost:24224 tag="app"
	```

	or, if you are using `docker compose`:
	```yml
	version: '3'

	services:
	  app:
	    build: .
	      - "80:80"
		logging:
		  driver: "fluentd"
		  options:
		    fluentd-address: localhost:24224
		    tag: app
    ...
	```

That it! Now you can start generating logs from your docker container and then navigate to newrelic dashboard to view them.
