# Data Mining Project Template

This repository contains the code for a small data mining project developed as part of the course:

**Data Access and Data Mining for Social Sciences**

University of Lucerne

Student Name: Laura Rios  
Course: Data Mining for Political and Social Sciences using R
Term: Spring 2026

## Project Goal

The goal of this project is to collect and analyze data from an online source (API) in order to answer a research question relevant to political or social science.

The project should demonstrate:

- Identification of a suitable data source
- Automated data collection (API or scraping)
- Data cleaning and preparation
- Reproducible analysis


## Research Question

*"How is women’s economic participation related to the distribution of unpaid care work across countries?"*

## Data Source

The data source is the World Bank API: https://genderdata.worldbank.org/en/help#AccessAPI, were I selected 4 indicators:

1) Unpaid Care Work	(SG.TIM.UWRK.FE). Proportion of time (24h) spent by women on unpaid domestic and care work.
2) Female Labor Participation	(SL.TLF.CACT.FE.ZS)	Labor force participation rate, female (% of female population ages 15+).
3) Contributing Family Workers (SL.FAM.WORK.FE.ZS)	Contributing family workers, female (% of female employment).
4) GDP per capita (PPP)	(NY.GDP.PCAP.PP.CD)	GDP per capita based on purchasing power parity (current international $).

Example:

- API: https://example-api.com
- Documentation: https://example-api.com/docs
- Access method: To collect the data, I used the World Bank Open Data API. Access was gained programmatically via the R language, using the specialised WDI package. Technically, this process relies on HTTP GET requests sent to the endpoints.


## Repository Structure

/scripts     scripts used to collect/process data
/plots     plots generated through the process
/data_raw    generated jsons for every indicator            
/data_preprocessed    master dataset
README.md   project description


## Reproducibility

To reproduce this project:

1. Clone the repository
2. Install required R packages
3. Run the scripts in the `scripts/` folder

All data should be generated automatically by the scripts.


## Good Practices

Please follow these guidelines:

- Do **not upload raw datasets** to GitHub.
- Store **API keys outside the repository** (e.g., environment variables).
- Write scripts that run **from start to finish**.
- Commit your work **frequently**.
- Use **clear commit messages**.

Example commit messages:
added API request
cleaned dataset structure
added visualization
fixed JSON parsing


## Notes

Large datasets should not be pushed to GitHub.  
If necessary, provide instructions for downloading the data instead.
