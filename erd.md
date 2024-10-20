``` mermaid
erDiagram
  users {
    bigint id PK
    string name
    string access_token
  }

  repositories {
    bigint id PK
    bigint user FK
    string name
    string path
  }

  file_items {
    bigint id PK
    bigint repository_id FK
    string name
    int type
    text content
    bigint parent_id
  }

  file_item_closures {
    bigint ancestor_id FK
    bigint descendant_id FK
    int generations
  }

  users || --o{ repositories : "has-many"
  repositories || --o{ file_items : "has-many"
  file_items || --o{ file_item_closures : "has-many ancestors"
  file_items || --o{ file_item_closures : "has-many descendants"
```
