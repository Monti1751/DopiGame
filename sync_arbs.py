import json
import os
import glob
import shutil
from collections import OrderedDict

def copy_assets():
    artifact_dir = r"C:\Users\Monti\.gemini\antigravity\brain\274a56a6-feb6-4ccd-9aff-74f3804bdd13"
    target_dir = r"D:\GitHub\DopiGame\assets\images"
    
    if not os.path.exists(target_dir):
        os.makedirs(target_dir, exist_ok=True)
    
    assets = {
        "capybara_tea_party_background_new_1773678420675.png": "capybara_tea_party_background.png",
        "capybara_icon_new_1773678692785.png": "icon.png"
    }
    
    for src_name, dest_name in assets.items():
        src_path = os.path.join(artifact_dir, src_name)
        dest_path = os.path.join(target_dir, dest_name)
        try:
            if os.path.exists(src_path):
                shutil.copy2(src_path, dest_path)
                print(f"SUCCESS: Copied {src_name} to {dest_name}")
            else:
                print(f"ERROR: Source not found: {src_path}")
        except Exception as e:
            print(f"ERROR: Failed to copy {src_name}: {e}")

def sync_arbs():
    arb_dir = r"D:\GitHub\DopiGame\lib\l10n"
    template_path = os.path.join(arb_dir, "app_en.arb")
    
    if not os.path.exists(template_path):
        print(f"ERROR: Template not found: {template_path}")
        return

    with open(template_path, 'r', encoding='utf-8') as f:
        template_data = json.load(f, object_pairs_hook=OrderedDict)
    
    arb_files = glob.glob(os.path.join(arb_dir, "*.arb"))
    
    for file_path in arb_files:
        if file_path == template_path:
            continue
            
        try:
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
                print(f"SUCCESS: Updated {os.path.basename(file_path)}")
        except Exception as e:
            print(f"ERROR: Failed to process {file_path}: {e}")

if __name__ == "__main__":
    print("Starting sync process...")
    copy_assets()
    sync_arbs()
    print("Sync process finished.")
