# Miscellaneous

Additional Information, Tips

## Cloud Shell timed out

After 30 minutes of inactivity and after 4 hours of continuous work the Cloud Shell is reset. 

To resume your work:

1. Start a new Cloud Shell
2. Clone the repo: `git clone https://github.com/Harald-U/istio-handson.git`
3. `cd istio-handson/deployment/`
4. Get the environment: `./get-env.sh`
5. Set the environment: `source local.env`
6. Display relevant URLS: `./show-urls.sh`

You are ready to go again!

## Delete the sample

Execute the following script (in deployment directory):

```
./delete-all.sh
```

It disables mTLS and deletes the Cloud Native Starter smaple and its Istio configuration.
It does not delete the LogDNA Agent, if installed, you can delete the DaemonSet manually.
It also does not delete Istio.

Please remember: the lite Kubernetes cluster will be automatically removed after 30 days.