# Where in the World is Carmen Sandiego? - dbt Data Engineering Project

## 🔍 Project Overview

This dbt project analyzes Carmen Sandiego sighting data from 8 different Interpol regional agencies to answer key analytical questions about her whereabouts, behavior patterns, and operational characteristics. The project transforms messy, multi-language Excel data into a clean, normalized data warehouse optimized for analytical queries.

## 🗄️ Database Choice

**PostgreSQL** - Selected for its robust support for:
- Advanced analytics and window functions
- Excellent dbt integration and materialization strategies
- Strong data type handling for geographic coordinates
- Reliable handling of Unicode characters (Chinese column names in Asia data)

## 📊 Data Structure Analysis

### Source Data Overview
The Excel workbook `carmen_sightings_20220629061307.xlsx` contains 8 regional sheets:

| Region | Records | HQ City | Language/Dialect | Key Differences |
|--------|---------|---------|------------------|----------------|
| EUROPE | 4,200 | London | English | French terms (chapeau, coat) |
| ASIA | 3,836 | Samarkand | Chinese/English | Chinese column names (纬度/经度) |
| AFRICA | 1,193 | Casablanca | English | Standard format |
| AMERICA | 4,022 | Caracas | English | Standard format |
| AUSTRALIA | 166 | Sydney | English | Unique terms (field_chap, place) |
| ATLANTIC | 29 | Canary Islands | English | Standard format |
| INDIAN | 77 | Reunion | English | Standard format |
| PACIFIC | 67 | Auckland | English | Unique terms (sight_on, town) |

**Total Dataset**: 13,590 Carmen Sandiego sightings across 30+ years

### Column Mapping Challenges
Each regional agency uses different column naming conventions:

```
Standard → EUROPE → ASIA → AUSTRALIA → PACIFIC
date_witness → date_witness → sighting → witnessed → sight_on
agent → agent → officer → field_chap → filer  
latitude → lat_ → 纬度 → lat → lat
has_hat → chapeau? → has_hat → has_hat → has_hat
```

## 🏗️ dbt Project Architecture

### Directory Structure
```
carmen_sandiego/
├── dbt_project.yml          # Project configuration
├── models/
│   ├── staging/             # Source data standardization
│   │   ├── _sources.yml     # Source definitions
│   │   ├── stg_europe_sightings.sql
│   │   ├── stg_asia_sightings.sql
│   │   └── ... (6 more regional staging models)
│   ├── intermediate/        # Data consolidation
│   │   └── int_all_sightings.sql
│   ├── marts/
│   │   ├── core/           # Normalized dimension/fact tables
│   │   │   ├── dim_agents.sql
│   │   │   ├── dim_witnesses.sql
│   │   │   ├── dim_locations.sql
│   │   │   └── fact_sightings.sql
│   │   └── analytics/      # Business question answers
│   │       ├── monthly_region_probability.sql
│   │       ├── monthly_appearance_probability.sql
│   │       ├── top_behaviors.sql
│   │       └── monthly_behavior_probability.sql
├── macros/                 # Reusable SQL functions
├