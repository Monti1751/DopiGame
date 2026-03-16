import json
import os
import glob
from collections import OrderedDict

# English and Spanish manual translations, others fall back to English for now map
translations = {
    "en": {
        "addTaskTitle": "Add New Task",
        "taskNameLabel": "Task Name",
        "taskNameHint": "E.g., Read 10 pages",
        "taskDescriptionLabel": "Description (Optional)",
        "taskDescriptionHint": "Add more details here...",
        "categoryLabel": "Category",
        "dueDateLabel": "Due Date",
        "priorityLabel": "Priority",
        "priorityNormal": "Normal (1x XP)",
        "priorityHigh": "High (1.5x XP)",
        "saveTaskButton": "Save Task",
        "errorRequiredField": "This field is required"
    },
    "es": {
        "addTaskTitle": "Añadir Nueva Tarea",
        "taskNameLabel": "Nombre de la tarea",
        "taskNameHint": "Ej., Leer 10 páginas",
        "taskDescriptionLabel": "Descripción (Opcional)",
        "taskDescriptionHint": "Añade más detalles aquí...",
        "categoryLabel": "Categoría",
        "dueDateLabel": "Fecha Límite",
        "priorityLabel": "Prioridad",
        "priorityNormal": "Normal (1x XP)",
        "priorityHigh": "Alta (1.5x XP)",
        "saveTaskButton": "Guardar Tarea",
        "errorRequiredField": "Este campo es obligatorio"
    }
}

arb_dir = r"D:\GitHub\DopiGame\lib\l10n"
arb_files = glob.glob(os.path.join(arb_dir, "*.arb"))

for file_path in arb_files:
    filename = os.path.basename(file_path)
    lang_code = filename.split('_')[1].split('.')[0]
    
    with open(file_path, 'r', encoding='utf-8') as f:
        data = json.load(f, object_pairs_hook=OrderedDict)
    
    trans_map = translations.get(lang_code, translations["en"])
    
    for key, value in trans_map.items():
        if key not in data:
            data[key] = value
            
    with open(file_path, 'w', encoding='utf-8') as f:
        json.dump(data, f, ensure_ascii=False, indent=2)

print(f"Updated {len(arb_files)} ARB files successfully.")
