# Azure Cloud Fundamentals and Data Pipeline Implementation using Azure Data Factory

## Objective

To understand Azure cloud concepts and build an end-to-end data pipeline using Azure Storage Account and Azure Data Factory (ADF).

---

## Services Used

- Azure Resource Group
- Azure Storage Account
- Azure Blob Container
- Azure Data Factory
- Azure Blob Storage
- Linked Service
- Source Dataset
- Destination Dataset
- Get Metadata Activity
- Copy Data Activity

---

## Implementation Steps

1. Created a Resource Group.
2. Created an Azure Storage Account.
3. Created a Blob Container and uploaded the Superstore CSV file.
4. Created Azure Data Factory.
5. Configured a Linked Service using the Storage Account Key.
6. Created Source and Destination datasets.
7. Added a Get Metadata activity to validate the source file.
8. Added a Copy Data activity to copy the file.
9. Validated and published the pipeline.
10. Executed the pipeline using Debug.
11. Verified successful pipeline execution.
12. Verified the generated Output_Superstore.csv file.

---

## Pipeline Flow

Blob Storage (Source)
        ↓
Get Metadata
        ↓
Copy Data
        ↓
Blob Storage (Destination)

---

## Output

The pipeline executed successfully. The metadata of the source file was validated, and the CSV file was copied successfully to the destination as **Output_Superstore.csv**.

---

## Project Structure

```text
Assignment_04/
│
├── Azure Cloud Fundamentals and Data Pipeline.md
├── README.md
│
└── Screenshots/
    ├── 004.png
    ├── 01_Resource_Group.png
    ├── 02_Storage_Account.png
    ├── 03_Blob_Container_CSV.png
    ├── 04_Azure_Data_Factory_Overview.png
    ├── 05_ADF_Studio_Home.png
    ├── 06_Linked_Service.png
    ├── 07_Source_Dataset_Published.png
    ├── 08_Destination_Dataset.png
    ├── 09_Get_Metadata_Activity.png
    ├── 10A_Source_Tab.png
    ├── 10B_Sink_Tab.png
    ├── 11_Pipeline_Execution_&_Success.png
    ├── 12_Output_Superstore_Copy.png
    └── 13_IAM.png
```

---

## Result

The Azure Data Factory pipeline was successfully built, validated, published, and executed. The source CSV file stored in Azure Blob Storage was successfully copied to the destination container using Azure Data Factory.
