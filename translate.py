import json
import os
import glob

def main():
    arb_dir = "lib/l10n"
    es_file = os.path.join(arb_dir, "app_es.arb")
    
    with open(es_file, "r", encoding="utf-8") as f:
        es_data = json.load(f)
        
    arb_files = glob.glob(os.path.join(arb_dir, "app_*.arb"))
    for file in arb_files:
        if file == es_file:
            continue
            
        with open(file, "r", encoding="utf-8") as f:
            try:
                data = json.load(f)
            except:
                continue
                
        # Copy keys from es_data to data if they don't exist
        for key, value in es_data.items():
            if key not in data:
                data[key] = value
                
        with open(file, "w", encoding="utf-8") as f:
            json.dump(data, f, ensure_ascii=False, indent=2)
            
    print("Localization keys synced successfully!")

if __name__ == "__main__":
    main()
