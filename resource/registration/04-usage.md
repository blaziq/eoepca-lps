We already have a sample process `hello-world` that comes pre-registered with the Resource Registration Building Block.

Firt, we check the details of the process:
```
source ~/.eoepca/state
curl -s "http://registration-api.eoepca.local/processes/hello-world" | jq
```{{exec}}

Synchronous execution of `hello-world` process. This will wait for the completion of the job spawned from the process and return the results to the terminal. The result is expected to be the message we send to execute the process.
```
curl -s -X POST "http://registration-api.eoepca.local/processes/hello-world/execution" \
-H "Content-Type: application/json" \
-d '{
   "inputs": {
      "name": "Resource Registration Validation Tester",
      "message": "This confirms that the Registration API is working correctly."
   }
}' | jq
```{{exec}}

Asynchronous execution of `hello-world` process. When the execution is called in the asynchronous mode, it does not wait for job completion and does not show the results since the job is running "in the background". Instead, it returns the job URL in the HTTP response header "Location". We capture this value in a variable and use it to later retrieve job details.
```
source ~/.eoepca/state
ASYNC_JOB=$(curl -s -D - -X POST "http://registration-api.eoepca.local/processes/hello-world/execution" \
 -H "Content-Type: application/json" \
 -H "Prefer: respond-async" \
 -d '{
   "inputs": {
      "name": "Resource Registration Validation Tester",
      "message": "This confirms that the Registration API is working correctly."
   }
}'  | awk -F': ' '/^Location:/ {print $2}' | tr -d '\r\n')
echo ${ASYNC_JOB}
```{{exec}}

Now we check the status of our asynchronous job. Since we executed a process that doesn't really do anything, it finished instantly so we can't expect the job to be still running.
```
curl -s ${ASYNC_JOB} | jq
```{{exec}}

We can see that the job completed (`"message": "job complete") successfully ("status": "succesful"). We also see links to results in the HTML and JSON formats. Let's check what the results JSON look like:
```
curl -s ${ASYNC_JOB}/results?f=json  | jq
``` 

The result is indeed the same as with the synchronous execution.



