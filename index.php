<?php
require_once __DIR__ . '/config/Database.php';
require_once __DIR__ . '/controllers/GameController.php';
require_once __DIR__ . '/utils/Response.php';

// CORS Headers
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

// Get database connection
$database = new Database();
$db = $database->getConnection();

if (!$db) {
    Response::error('Database connection failed', 500);
}

// Parse URL
$uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
$uri = trim($uri, '/');
$uriParts = explode('/', $uri);

// Routing: /game_api/api/games/{id}
// Find the position of 'api' in the URL
$apiIndex = array_search('api', $uriParts);

if ($apiIndex !== false && isset($uriParts[$apiIndex + 1])) {
    $endpoint = $uriParts[$apiIndex + 1];
    
    if ($endpoint === 'games') {
        $id = $uriParts[$apiIndex + 2] ?? null;
        $method = $_SERVER['REQUEST_METHOD'];
        
        $controller = new GameController($db);
        $controller->handleRequest($method, $id);
    } else {
        Response::error('Endpoint not found', 404);
    }
} else {
    // Display API info if accessing root
    Response::json([
        'name' => 'Game API',
        'version' => '1.0.0',
        'endpoints' => [
            'GET /api/games' => 'Get all games',
            'GET /api/games/{id}' => 'Get game by ID',
            'POST /api/games' => 'Create new game',
            'PUT /api/games/{id}' => 'Update game',
            'DELETE /api/games/{id}' => 'Delete game'
        ]
    ]);
}