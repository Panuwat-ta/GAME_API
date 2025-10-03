# 🎮 Game API - RESTful API สำหรับจัดการข้อมูลเกม

## 📖 รายละเอียด
REST API สำหรับจัดการฐานข้อมูลเกม รองรับการดึงข้อมูล, เพิ่ม, แก้ไข และลบข้อมูลเกม พร้อมระบบกรองและค้นหาข้อมูลขั้นสูง

### 1️⃣ ดูเกมทั้งหมด
**GET** `/games`

#### Query Parameters

| Parameter | Type | Description | Example |
|-----------|------|-------------|---------|
| `genre` | string | กรองตามประเภทเกม | `RPG`, `Action`, `Roguelike` |
| `platform` | string | กรองตามแพลตฟอร์ม | `PC`, `PS5`, `Switch` |
| `min_price` | float | ราคาต่ำสุด | `500` |
| `max_price` | float | ราคาสูงสุด | `2000` |
| `min_rating` | float | คะแนนต่ำสุด | `9.0` |
| `multiplayer` | boolean | กรองเฉพาะเกมมัลติเพลเยอร์ | `true`, `false` |
| `search` | string | ค้นหาจากชื่อเกมหรือผู้พัฒนา | `souls` |
| `sort` | string | เรียงลำดับ | `price_asc`, `price_desc`, `rating_desc`, `year_desc`, `title_asc` |
| `page` | integer | หน้าที่ต้องการ | `1` (default) |
| `per_page` | integer | จำนวนต่อหน้า | `10` (default) |

#### ตัวอย่างการเรียกใช้

**ดูเกมทั้งหมด**
```
GET http://localhost/game_api/api/games
```

**ดูเกม RPG ที่มีคะแนนสูงกว่า 9.0**
```
GET http://localhost/game_api/api/games?genre=RPG&min_rating=9.0&sort=rating_desc
```

**ดูเกมบน PC ราคา 500-2000 บาท**
```
GET http://localhost/game_api/api/games?platform=PC&min_price=500&max_price=2000&sort=price_asc
```

**ค้นหาเกมที่มีคำว่า "souls"**
```
GET http://localhost/game_api/api/games?search=souls
```

**ดูเกมมัลติเพลเยอร์**
```
GET http://localhost/game_api/api/games?multiplayer=true&sort=rating_desc
```

---

### 2️⃣ ดูเกมตาม ID
**GET** `/games/{id}`

#### ตัวอย่างการเรียกใช้
```
GET http://localhost/game_api/api/games/1
```

---

### 3️⃣ เพิ่มเกมใหม่
**POST** `/games`

#### Request Headers
```
Content-Type: application/json
```

#### ตัวอย่างการเรียกใช้
```
POST http://localhost/game_api/api/games
Content-Type: application/json

{
    "game_code": "HORROR-01",
    "title": "Resident Evil 9",
    "developer": "Capcom",
    "publisher": "Capcom",
    "genre": "Survival Horror",
    "platform": "PC, PS5, Xbox",
    "release_year": 2024,
    "price": 2190.00,
    "stock": 50,
    "rating": 9.2,
    "multiplayer": false,
    "description": "The next chapter in survival horror"
}
```
---

### 4️⃣ แก้ไขข้อมูลเกม
**PUT** `/games/{id}` หรือ **PATCH** `/games/{id}`

#### Request Headers
```
Content-Type: application/json
```

#### ตัวอย่างการเรียกใช้

**แก้ไขราคาและจำนวนสต็อก**
```
PUT http://localhost/game_api/api/games/1
Content-Type: application/json

{
    "price": 1690.00,
    "stock": 120
}
```

**อัพเดทคะแนน**
```
PATCH http://localhost/game_api/api/games/1
Content-Type: application/json

{
    "rating": 9.8
}
```

---

### 5️⃣ ลบเกม
**DELETE** `/games/{id}`

#### ตัวอย่างการเรียกใช้
```
DELETE http://localhost/game_api/api/games/31
```
---

## 📊 โครงสร้างฐานข้อมูล

### ตาราง `games`

| Column | Type | Description |
|--------|------|-------------|
| `id` | INT (PK, AUTO_INCREMENT) | รหัสเกม |
| `game_code` | VARCHAR(32) UNIQUE | รหัสเกม (ไม่ซ้ำ) |
| `title` | VARCHAR(150) | ชื่อเกม |
| `developer` | VARCHAR(100) | ผู้พัฒนา |
| `publisher` | VARCHAR(100) | ผู้จัดจำหน่าย |
| `genre` | VARCHAR(50) | ประเภทเกม |
| `platform` | VARCHAR(100) | แพลตฟอร์ม |
| `release_year` | INT | ปีที่วางจำหน่าย |
| `price` | DECIMAL(10,2) | ราคา |
| `stock` | INT | จำนวนสต็อก |
| `rating` | DECIMAL(3,1) | คะแนน (0-10) |
| `multiplayer` | BOOLEAN | รองรับมัลติเพลเยอร์หรือไม่ |
| `description` | TEXT | คำอธิบาย |
| `created_at` | TIMESTAMP | วันที่สร้าง |
| `updated_at` | TIMESTAMP | วันที่แก้ไขล่าสุด |

---

## 🎯 ตัวอย่างการใช้งาน

### ตัวอย่างที่ 1: ค้นหาเกม RPG ที่มีคะแนนสูง
```http
GET http://localhost/game_api/api/games?genre=RPG&min_rating=9.0&sort=rating_desc
```

### ตัวอย่างที่ 2: ดูเกมราคาถูกบน PC
```http
GET http://localhost/game_api/api/games?platform=PC&max_price=1000&sort=price_asc
```

### ตัวอย่างที่ 3: เพิ่มเกมใหม่
```http
POST http://localhost/game_api/api/games
Content-Type: application/json

{
    "game_code": "FF16-01",
    "title": "Final Fantasy XVI",
    "developer": "Square Enix",
    "publisher": "Square Enix",
    "genre": "Action RPG",
    "platform": "PS5, PC",
    "release_year": 2023,
    "price": 2190.00,
    "stock": 40,
    "rating": 8.8,
    "multiplayer": false,
    "description": "The latest in the legendary Final Fantasy series"
}
```

### ตัวอย่างที่ 4: ลดราคาเกม
```http
PUT http://localhost/game_api/api/games/5
Content-Type: application/json

{
    "price": 990.00
}
```

### ตัวอย่างที่ 5: ค้นหาเกมที่มี "Dark Souls" ในชื่อ
```http
GET http://localhost/game_api/api/games?search=dark%20souls
```

---

## 📸 ภาพตัวอย่างการทดสอบ

### 1. GET All Games
ดึงข้อมูลเกมทั้งหมดในระบบ

![GET All Games](/img/get-all.png)

---

### 2. GET Game by ID
ดึงข้อมูลเกมตาม ID ที่ระบุ

![GET Game by ID](/img/get-game-id.png)

---

### 3. POST Create Game
เพิ่มเกมใหม่เข้าสู่ระบบ

![POST Create Game](/img/post-Create-game.png)
---

### 4. PUT Update Game
แก้ไขข้อมูลเกมที่มีอยู่

![PUT Update Game](/img/put-Update-Game.png)

---

### 5. DELETE Game
ลบเกมออกจากระบบ

![DELETE Game](/img/DELETE-Game.png)

---

### 6. GET with Filters
ค้นหาและกรองข้อมูลเกม

![GET with Filters](/img/get-Filters-game.png)

---

## ⚠️ HTTP Status Codes

| Status Code | Description |
|-------------|-------------|
| 200 | สำเร็จ (OK) |
| 201 | สร้างสำเร็จ (Created) |
| 400 | ข้อมูลไม่ถูกต้อง (Bad Request) |
| 404 | ไม่พบข้อมูล (Not Found) |
| 405 | Method ไม่รองรับ (Method Not Allowed) |
| 409 | ข้อมูลซ้ำ (Conflict) |
| 500 | เกิดข้อผิดพลาดบนเซิร์ฟเวอร์ (Internal Server Error) |

---

## 💡 เคล็ดลับการใช้งาน

### 1. ใช้ Pagination เพื่อประสิทธิภาพที่ดีขึ้น
```
GET /api/games?page=1&per_page=20
```

### 2. รวมหลาย Filter เข้าด้วยกัน
```
GET /api/games?genre=RPG&platform=PC&min_price=500&max_price=1500&sort=rating_desc
```

### 3. ใช้ Search สำหรับค้นหาทั่วไป
```
GET /api/games?search=final%20fantasy
```

### 4. ทดสอบ API ด้วย cURL
```bash
# GET
curl http://localhost/game_api/api/games

# POST
curl -X POST http://localhost/game_api/api/games \
  -H "Content-Type: application/json" \
  -d '{"game_code":"TEST-01","title":"Test Game",...}'

# PUT
curl -X PUT http://localhost/game_api/api/games/1 \
  -H "Content-Type: application/json" \
  -d '{"price":999.00}'

# DELETE
curl -X DELETE http://localhost/game_api/api/games/1
```

