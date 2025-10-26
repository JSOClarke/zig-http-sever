| Feature | Description | Status |
|---------|-------------|--------|
| Routing - URL mapping | Map URLs to handler functions (/users, GET, POST, etc.) | |
| Routing - Path parameters | Support path parameters like /users/:id | |
| Routing - Query parameters | Optional support for query strings like ?page=2 | |
| Request Handling - Method | Parse HTTP method (GET, POST, PUT, DELETE) | | -> Completed 
| Request Handling - URL/Path | Parse the URL and path | |
| Request Handling - Headers | Parse HTTP headers | | -> Started Near completion.
| Request Handling - Body | Parse request body (JSON or form data) | |
| Response Handling - Status codes | Return proper HTTP status codes (200, 404, 500) | |
| Response Handling - Headers | Set response headers (Content-Type, Location) | |
| Response Handling - Body | Return response body (JSON or HTML) | |
| Response Handling - Helpers | Optional helper functions like json(), text() | |
| Middleware - Logging | Log incoming requests | |
| Middleware - Error handling | Catch and handle errors gracefully | |
| Middleware - Auth | Optional authentication/authorization middleware | |
| Middleware - Body parser | Parse request body for JSON/form data | |
| Controller - Create | Implement POST /resource to add new item | |
| Controller - Read | Implement GET /resource to list items | |
| Controller - Read Single | Implement GET /resource/:id to get single item | |
| Controller - Update | Implement PUT /resource/:id to update item | |
| Controller - Delete | Implement DELETE /resource/:id to remove item | |
| Persistence - In-memory storage | Use array or dictionary to store data temporarily | |
| Persistence - File storage | Optional: store data in a JSON file | |
| Error Handling - 404 | Return 404 for unknown routes | |
| Error Handling - 400 | Return 400 for bad requests | |
| Error Handling - 500 | Return 500 for server errors | |
| Utilities - JSON | Parse and serialize JSON | |
| Utilities - URL/path matching | Helper to match URL paths to routes | |
| Utilities - Logging | Basic request/response logging | |
| Optional - Router grouping | Group routes under a common prefix (/users) | |
| Optional - Templating | Support HTML templating | |
| Optional - Validation | Validate request body data | |
| Optional - Auto API docs | Provide a /help endpoint listing routes and usage | |
