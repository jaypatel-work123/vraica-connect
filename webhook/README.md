# Webhooks Example

![webhook](./webhooks.png)

This example shows how to set up a server to listen for Vraica connect webhook events (join, exitRoom, disconnect).

### Step 1: Enable Webhooks

Edit `app/src/config.js` to enable webhooks:

```javascript
webhook: {
    enabled: true, // Enable webhook functionality
    url: 'http://localhost:8888/webhook-endpoint', // Webhook server URL
},
```

---

### Step 2: Run the Webhook Server

1. **Install dependencies**:

    ```bash
    npm install
    ```

2. **Start the server**:

    ```bash
    npm start
    ```

---

### Step 3: Webhook Events

Vraica connect sends HTTP `POST` requests to the specified URL with event data:

**Example Payload**:

```json
{
    "event": "join",
    "data": {}
}
```

- **Events**: `join`, `exit`, `disconnect`.
- **Data**: Includes `event` and custom `data`.
