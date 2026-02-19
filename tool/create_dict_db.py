import sqlite3
import os

def main():
    db_path = 'assets/db/dictionary.sqlite'
    os.makedirs('assets/db', exist_ok=True)
    
    if os.path.exists(db_path):
        os.remove(db_path)
        
    print("Opening database...")
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    
    # Create table matching Drift schema (mostly)
    # Drift adds 'id' INTEGER PRIMARY KEY AUTOINCREMENT
    cursor.execute('''
        CREATE TABLE dictionary (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            word TEXT UNIQUE,
            definition TEXT
        )
    ''')
    
    # 1. Load Definitions
    print("Loading definitions...")
    defs_map = {}
    try:
        with open('assets/ODS9_definitions.txt', 'r', encoding='utf-8') as f:
            for line in f:
                line = line.strip()
                if not line: continue
                
                parts = line.split(None, 1) # Split on first whitespace
                if len(parts) < 2: continue
                
                word_part = parts[0]
                def_part = parts[1]
                
                # Clean word (remove variants like ",ENNE")
                if ',' in word_part:
                    word_part = word_part.split(',')[0]
                
                defs_map[word_part] = def_part
        print(f"Loaded {len(defs_map)} definitions.")
    except FileNotFoundError:
        print("Warning: Definitions file not found.")

    # 2. Load Words
    print("Loading words...")
    try:
        with open('assets/ODS9.txt', 'r', encoding='utf-8') as f:
            words = [line.strip().upper() for line in f if line.strip()]
    except FileNotFoundError:
        print("Error: ODS9.txt not found.")
        return

    print(f"Inserting {len(words)} words...")
    
    # Batch insert
    batch_size = 10000
    data = []
    
    for word in words:
        definition = defs_map.get(word) # None if not found
        data.append((word, definition))
        
        if len(data) >= batch_size:
            cursor.executemany('INSERT OR IGNORE INTO dictionary (word, definition) VALUES (?, ?)', data)
            data = []
            print(f"Processed...")
            
    if data:
        cursor.executemany('INSERT OR IGNORE INTO dictionary (word, definition) VALUES (?, ?)', data)
        
    conn.commit()
    conn.close()
    print("Done! Dictionary generated.")

if __name__ == "__main__":
    main()
