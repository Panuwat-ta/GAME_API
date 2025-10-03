<?php
class Game {
    private $conn;
    private $table = "games";

    public function __construct($db) {
        $this->conn = $db;
    }

    // GET ALL with filters
    public function getAll($filters = []) {
        $query = "SELECT * FROM " . $this->table . " WHERE 1=1";
        $params = [];

        // Filter by genre
        if (!empty($filters['genre'])) {
            $query .= " AND genre = :genre";
            $params[':genre'] = $filters['genre'];
        }

        // Filter by platform
        if (!empty($filters['platform'])) {
            $query .= " AND platform LIKE :platform";
            $params[':platform'] = '%' . $filters['platform'] . '%';
        }

        // Filter by price range
        if (!empty($filters['min_price'])) {
            $query .= " AND price >= :min_price";
            $params[':min_price'] = $filters['min_price'];
        }
        if (!empty($filters['max_price'])) {
            $query .= " AND price <= :max_price";
            $params[':max_price'] = $filters['max_price'];
        }

        // Filter by rating
        if (!empty($filters['min_rating'])) {
            $query .= " AND rating >= :min_rating";
            $params[':min_rating'] = $filters['min_rating'];
        }

        // Filter by multiplayer
        if (isset($filters['multiplayer'])) {
            $query .= " AND multiplayer = :multiplayer";
            $params[':multiplayer'] = $filters['multiplayer'] ? 1 : 0;
        }

        // Search by title
        if (!empty($filters['search'])) {
            $query .= " AND (title LIKE :search OR developer LIKE :search2)";
            $params[':search'] = '%' . $filters['search'] . '%';
            $params[':search2'] = '%' . $filters['search'] . '%';
        }

        // Sorting
        $sortField = 'id';
        $sortOrder = 'ASC';
        if (!empty($filters['sort'])) {
            switch ($filters['sort']) {
                case 'price_asc':
                    $sortField = 'price';
                    $sortOrder = 'ASC';
                    break;
                case 'price_desc':
                    $sortField = 'price';
                    $sortOrder = 'DESC';
                    break;
                case 'rating_desc':
                    $sortField = 'rating';
                    $sortOrder = 'DESC';
                    break;
                case 'year_desc':
                    $sortField = 'release_year';
                    $sortOrder = 'DESC';
                    break;
                case 'title_asc':
                    $sortField = 'title';
                    $sortOrder = 'ASC';
                    break;
            }
        }
        $query .= " ORDER BY {$sortField} {$sortOrder}";

        // Pagination
        $page = !empty($filters['page']) ? (int)$filters['page'] : 1;
        $perPage = !empty($filters['per_page']) ? (int)$filters['per_page'] : 10;
        $offset = ($page - 1) * $perPage;
        $query .= " LIMIT :limit OFFSET :offset";

        $stmt = $this->conn->prepare($query);
        foreach ($params as $key => $val) {
            $stmt->bindValue($key, $val);
        }
        $stmt->bindValue(':limit', $perPage, PDO::PARAM_INT);
        $stmt->bindValue(':offset', $offset, PDO::PARAM_INT);
        $stmt->execute();

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    // GET ONE by ID
    public function getById($id) {
        $query = "SELECT * FROM " . $this->table . " WHERE id = :id LIMIT 1";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    // CREATE
    public function create($data) {
        $query = "INSERT INTO " . $this->table . " 
                  (game_code, title, developer, publisher, genre, platform, release_year, 
                   price, stock, rating, multiplayer, description) 
                  VALUES (:game_code, :title, :developer, :publisher, :genre, :platform, 
                          :release_year, :price, :stock, :rating, :multiplayer, :description)";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(':game_code', $data['game_code']);
        $stmt->bindParam(':title', $data['title']);
        $stmt->bindParam(':developer', $data['developer']);
        $stmt->bindParam(':publisher', $data['publisher']);
        $stmt->bindParam(':genre', $data['genre']);
        $stmt->bindParam(':platform', $data['platform']);
        $stmt->bindParam(':release_year', $data['release_year']);
        $stmt->bindParam(':price', $data['price']);
        $stmt->bindParam(':stock', $data['stock']);
        $stmt->bindParam(':rating', $data['rating']);
        $stmt->bindParam(':multiplayer', $data['multiplayer']);
        $stmt->bindParam(':description', $data['description']);

        if ($stmt->execute()) {
            return $this->getById($this->conn->lastInsertId());
        }
        return false;
    }

    // UPDATE
    public function update($id, $data) {
        $fields = [];
        $params = [':id' => $id];

        $allowedFields = ['game_code', 'title', 'developer', 'publisher', 'genre', 
                          'platform', 'release_year', 'price', 'stock', 'rating', 
                          'multiplayer', 'description'];
        
        foreach ($allowedFields as $field) {
            if (isset($data[$field])) {
                $fields[] = "$field = :$field";
                $params[":$field"] = $data[$field];
            }
        }

        if (empty($fields)) {
            return false;
        }

        $query = "UPDATE " . $this->table . " SET " . implode(', ', $fields) . " WHERE id = :id";
        $stmt = $this->conn->prepare($query);
        
        if ($stmt->execute($params)) {
            return $this->getById($id);
        }
        return false;
    }

    // DELETE
    public function delete($id) {
        $query = "DELETE FROM " . $this->table . " WHERE id = :id";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        return $stmt->execute();
    }

    // GET GENRES (helper function)
    public function getGenres() {
        $query = "SELECT DISTINCT genre FROM " . $this->table . " ORDER BY genre";
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_COLUMN);
    }
}