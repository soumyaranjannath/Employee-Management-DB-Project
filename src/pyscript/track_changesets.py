import hashlib
import os
import time
from lxml import etree
import json


changeset_dir = 'src/dbresources'
changelog_file = 'src/changelogs/changelog.xml'
metadata_file = 'src/pyresources/dbfile_metadata.json'


NAMESPACE = "http://www.liquibase.org/xml/ns/dbchangelog"


def load_file_metadata():
    if os.path.exists(metadata_file):
        with open(metadata_file, 'r') as f:
            return json.load(f)
    return {}


def save_file_metadata(metadata):
    with open(metadata_file, 'w') as f:
        json.dump(metadata, f, indent=4)


def get_file_checksum(file_path):
    hash_md5 = hashlib.md5()
    with open(file_path, "rb") as f:
        for chunk in iter(lambda: f.read(4096), b""):
            hash_md5.update(chunk)
    return hash_md5.hexdigest()


def normalize_path(file_path):
    return os.path.normpath(file_path)


def update_changelog(changeset_file):
    print(f"Updating changelog with: {changeset_file}")
    if os.path.exists(changelog_file) and os.path.getsize(changelog_file) > 0:
        tree = etree.parse(changelog_file)
        root = tree.getroot()
    else:


        root = etree.Element("{%s}databaseChangeLog" % NAMESPACE,
                             nsmap={None: NAMESPACE},  
                             xsi="http://www.w3.org/2001/XMLSchema-instance",
                             xsi_schemaLocation="http://www.liquibase.org/xml/ns/dbchangelog http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-3.8.xsd")
        tree = etree.ElementTree(root)
   
    file_name = os.path.basename(changeset_file)  
    existing_changesets = root.findall("{%s}changeSet" % NAMESPACE)
   
   
    for changeset in existing_changesets:
        sql_file = changeset.find("{%s}sqlFile" % NAMESPACE)
        if sql_file is not None and sql_file.get("path") == changeset_file:
            root.remove(changeset)
            print(f"Removed existing changeset: {changeset_file}")
            break  
   
    id=str(int(time.time()))
    changeset_id = f"{file_name}_{id}"
    change_set_attrib = {
        'id': changeset_id,
        'author': "Soumyaranjan"  #author_name
    }
   
    changeset_element = etree.SubElement(root, "{%s}changeSet" % NAMESPACE, **change_set_attrib)
    etree.SubElement(changeset_element, "{%s}sqlFile" % NAMESPACE, path=changeset_file)
   
    tree.write(changelog_file, pretty_print=True, xml_declaration=True, encoding="UTF-8")
    print(f"Changelog updated with changeset: {changeset_file}")


def get_modified_files(changeset_dir):
    modified_files = []
    for root, dirs, files in os.walk(changeset_dir):
        for file in files:
            if file.endswith(".sql"):  
                file_path = os.path.join(root, file)
                normalized_file_path = normalize_path(file_path)
                file_size = os.path.getsize(normalized_file_path)
                if file_size==0:
                    continue
                file_checksum = get_file_checksum(normalized_file_path)


                if normalized_file_path not in file_metadata or file_metadata[normalized_file_path]['size'] != file_size or file_metadata[normalized_file_path]['checksum'] != file_checksum:
                    modified_files.append(normalized_file_path)
                    file_metadata[normalized_file_path] = {'size': file_size, 'checksum': file_checksum}


    return modified_files


def main():
    global file_metadata
    file_metadata = load_file_metadata()
    while True:  
        modified_files = get_modified_files(changeset_dir)
        for file in modified_files:
            update_changelog(file)
       
        save_file_metadata(file_metadata)
        time.sleep(5)  


if __name__ == "__main__":
    main()
