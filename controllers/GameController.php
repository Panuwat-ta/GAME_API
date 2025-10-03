<?php
require_once __DIR__ . '/../models/Game.php';
require_once __DIR__ . '/../utils/Response.php';

class GameController {
    private $game;

    public function __construct($db) {
        $this->game = new Game($db);
    }

    public function handleRequest($method, $id = null) {
        switch ($method) {
            case 'GET':
                if ($id) {
                    $this->getOne($id);
                } else {
                    $this->getAll();
                }
                break;
            case 'POST':
                $this->create();
                break;
            case 'PUT':
            case 'PATCH':
                $this->update($id);
                break;
            case 'DELETE':
                $this->delete($id);
                break;
            default:
                Response::error('Method not allowed', 405);
        }
    }

    private function getAll() {
        $filters = [
            'genre' => $_GET['genre'] ?? null,
            'platform' => $_GET['platform'] ?? null,
            'min_price' => $_GET['min_price'] ?? null,
            'max_price' => $_GET['max_price'] ?? null,
            'min_rating' => $_GET['min_rating'] ?? null,
            'multiplayer' => isset($_GET['multiplayer']) ? filter_var($_GET['multiplayer'], FILTER_VALIDATE_BOOLEAN) : null,
            'search' => $_GET['search'] ?? null,
            'sort' => $_GET['sort'] ?? null,
            'page' => $_GET['page'] ?? 1,
            'per_page' => $_GET['per_page'] ?? 10
        ];

        $games = $this->game->getAll($filters);
        Response::json(['data' => $games, 'count' => count($games)], 200);
    }

    private function getOne($id) {
        $game = $this->game->getById($id);
        if ($game) {
            Response::json(['data' => $game], 200);
        } else {
            Response::error('Game not found', 404);
        }
    }

    private function create() {
        $data = json_decode(file_get_contents("php://input"), true);

        // Validation
        $required = ['game_code', 'title', 'developer', 'publisher', 'genre', 
                     'platform', 'release_year', 'price'];
        $errors = [];
        
        foreach ($required as $field) {
            if (empty($data[$field])) {
                $errors[$field] = "is required";
            }
        }

        if (!empty($errors)) {
            Response::error('Validation failed', 400, $errors);
        }

        // Set defaults
        $data['stock'] = $data['stock'] ?? 0;
        $data['rating'] = $data['rating'] ?? null;
        $data['multiplayer'] = isset($data['multiplayer']) ? (bool)$data['multiplayer'] : false;
        $data['description'] = $data['description'] ?? '';

        try {
            $result = $this->game->create($data);
            if ($result) {
                Response::json(['message' => 'Game created successfully', 'data' => $result], 201);
            } else {
                Response::error('Failed to create game', 500);
            }
        } catch (PDOException $e) {
            if ($e->getCode() == 23000) {
                Response::error('Game code already exists', 409);
            }
            Response::error('Database error', 500);
        }
    }

    private function update($id) {
        if (!$id) {
            Response::error('ID is required', 400);
        }

        $existing = $this->game->getById($id);
        if (!$existing) {
            Response::error('Game not found', 404);
        }

        $data = json_decode(file_get_contents("php://input"), true);

        try {
            $result = $this->game->update($id, $data);
            if ($result) {
                Response::json(['message' => 'Game updated successfully', 'data' => $result], 200);
            } else {
                Response::error('No fields to update', 400);
            }
        } catch (PDOException $e) {
            if ($e->getCode() == 23000) {
                Response::error('Game code already exists', 409);
            }
            Response::error('Database error', 500);
        }
    }

    private function delete($id) {
        if (!$id) {
            Response::error('ID is required', 400);
        }

        $existing = $this->game->getById($id);
        if (!$existing) {
            Response::error('Game not found', 404);
        }

        if ($this->game->delete($id)) {
            Response::json(['message' => 'Game deleted successfully'], 200);
        } else {
            Response::error('Failed to delete game', 500);
        }
    }
}