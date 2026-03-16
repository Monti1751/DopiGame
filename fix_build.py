import os
import json
import shutil
from collections import OrderedDict

def main():
    print("--- Starting Build Fix ---")
    
    # 1. Sync ARB files
    arb_dir = r"D:\GitHub\DopiGame\lib\l10n"
    template_path = os.path.join(arb_dir, "app_en.arb")
    
    print(f"Syncing ARBs from {template_path}")
    if os.path.exists(template_path):
        with open(template_path, 'r', encoding='utf-8') as f:
            template_data = json.load(f, object_pairs_hook=OrderedDict)
        
        for filename in os.listdir(arb_dir):
            if filename.endswith(".arb") and filename != "app_en.arb":
                file_path = os.path.join(arb_dir, filename)
                with open(file_path, 'r', encoding='utf-8') as f:
                    data = json.load(f, object_pairs_hook=OrderedDict)
                
                updated = False
                for key, value in template_data.items():
                    if key not in data:
                        data[key] = value
                        updated = True
                
                if updated:
                    with open(file_path, 'w', encoding='utf-8') as f:
                        json.dump(data, f, ensure_ascii=False, indent=2)
                    print(f"  [FIXED] {filename}")
    else:
        print(" [ERROR] Template ARB not found!")

    # 2. Restore Assets
    artifact_dir = r"C:\Users\Monti\.gemini\antigravity\brain\274a56a6-feb6-4ccd-9aff-74f3804bdd13"
    target_dir = r"D:\GitHub\DopiGame\assets\images"
    
    assets_to_copy = {
        "capybara_tea_party_background_new_1773678420675.png": "capybara_tea_party_background.png",
        "capybara_icon_new_1773678692785.png": "icon.png"
    }

    print(f"Restoring assets to {target_dir}")
    if not os.path.exists(target_dir):
        os.makedirs(target_dir)

    for src_name, dest_name in assets_to_copy.items():
        src_path = os.path.join(artifact_dir, src_name)
        dest_path = os.path.join(target_dir, dest_name)
        
        if os.path.exists(src_path):
            shutil.copyfile(src_path, dest_path)
            print(f"  [FIXED] Copied {src_name} to {dest_name}")
            # Verify file size
            print(f"          Size: {os.path.getsize(dest_path)} bytes")
        else:
            print(f"  [ERROR] Source not found: {src_path}")

    print("--- Build Fix Finished ---")

if __name__ == "__main__":
    main()
