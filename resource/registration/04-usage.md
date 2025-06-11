Synchronous Execution of Hello-World Process

```
source ~/.eoepca/state
curl -s -X POST "http://registration-api.eoepca.local/processes/hello-world/execution" \
-H "Content-Type: application/json" \
-d '{
   "inputs": {
      "name": "Resource Registration Validation Tester",
      "message": "This confirms that the Registration API is working correctly."
   }
}' | jq
``` {{exec}}


Asynchronous Execution of Hello-World Process

```
source ~/.eoepca/state
curl -s -X POST "http://registration-api.eoepca.local/processes/hello-world/execution" \
-H "Content-Type: application/json" \
-H "Prefer": "respond-async" \
-d '{
   "inputs": {
      "name": "Resource Registration Validation Tester",
      "message": "This confirms that the Registration API is working correctly."
   }
}' | jq
``` {{exec}}

Check Status of Async Job


