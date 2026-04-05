# Tableau Dashboard — Step-by-Step Build Guide

Follow these exact steps in **Tableau Public** (free) to create 3 impressive dashboards.

---

## Step 0: Connect Your Data

1. Open **Tableau Public** (download from https://public.tableau.com if needed)
2. Click **Connect** → **Text File** → navigate to `data/sleep_health_dataset.csv`
3. Once loaded, click **Sheet 1** at the bottom to start building

---

## Dashboard 1: Sleep Health KPI Overview

This dashboard gives recruiters an instant view of population health.

### Sheet 1.1 — KPI Bar (Sleep Duration)
1. Drag `Sleep Duration Hrs` to **Columns** → right-click → **Measure** → **Average**
2. Click **Show Me** → select **Text Table** (or just leave as bar)
3. Right-click the axis → **Add Reference Line** → set to **Constant = 7** (recommended minimum)
4. Add a label: right-click the mark → **Format** → increase font size
5. Rename sheet: double-click the tab → name it **"Avg Sleep Duration"**

### Sheet 1.2 — KPI Card (Felt Rested %)
1. New Sheet → Drag `Felt Rested` to **Text** on the Marks card
2. Right-click → **Measure** → **Average**
3. Format as percentage (right-click → **Format** → **Numbers** → **Percentage**)
4. Increase font size to 36pt, bold
5. Rename: **"Felt Rested %"**

### Sheet 1.3 — Risk Distribution Pie
1. New Sheet → Drag `Sleep Disorder Risk` to **Color** on Marks
2. Drag `Number of Records` (or `person_id` as Count) to **Angle**
3. Show Me → **Pie Chart**
4. Drag `Sleep Disorder Risk` to **Label** as well
5. Right-click label → **Quick Table Calculation** → **Percent of Total**
6. Rename: **"Risk Distribution"**

### Sheet 1.4 — Sleep Quality by Occupation (Bar)
1. New Sheet → Drag `Occupation` to **Rows**
2. Drag `Sleep Quality Score` to **Columns** → set to **Average**
3. Sort descending
4. Drag `Sleep Quality Score` (AVG) to **Color** → choose Red-Green diverging
5. Rename: **"Quality by Occupation"**

### Assemble Dashboard 1
1. Click **New Dashboard** (icon at bottom)
2. Set size: **Fixed** → **1200 × 800**
3. Drag all 4 sheets onto the dashboard canvas
4. Add a **Text** box at the top: **"Sleep Health KPI Overview"** (18pt, bold)
5. Arrange: KPI cards on top row, pie chart + bar chart on bottom row

---

## Dashboard 2: Risk Factor Deep-Dive

### Sheet 2.1 — Risk by Age Group
1. Create a **Calculated Field** (right-click in Data pane → **Create Calculated Field**):
   - Name: `Age Group`
   - Formula:
   ```
   IF [Age] <= 25 THEN "18-25"
   ELSEIF [Age] <= 35 THEN "26-35"
   ELSEIF [Age] <= 45 THEN "36-45"
   ELSEIF [Age] <= 55 THEN "46-55"
   ELSE "56-69"
   END
   ```
2. Drag `Age Group` to **Columns**
3. Drag `Number of Records` to **Rows**
4. Drag `Sleep Disorder Risk` to **Color**
5. Right-click Y-axis → **Quick Table Calculation** → **Percent of Total** → **Compute Using** → **Sleep Disorder Risk**
6. This gives you a **stacked percentage bar chart** by age
7. Rename: **"Risk by Age Group"**

### Sheet 2.2 — Mental Health Impact
1. Drag `Mental Health Condition` to **Columns**
2. Create 3 rows: drag `Sleep Quality Score` (AVG), `Sleep Duration Hrs` (AVG), `Cognitive Performance Score` (AVG) to **Rows** (use **Measure Values** shelf)
3. Alternatively: Drag all 3 measures to Rows → right-click each → Dual Axis → Synchronize (or use separate rows)
4. Color by `Mental Health Condition`
5. Rename: **"Mental Health Impact"**

### Sheet 2.3 — Shift Work Comparison
1. Drag `Shift Work` to **Columns** (rename labels: 0 = "No Shift", 1 = "Shift Work")
2. Drag `Sleep Quality Score` (AVG) to **Rows**
3. Add `Sleep Disorder Risk` to **Color** with percent of total
4. Rename: **"Shift Work Impact"**

### Assemble Dashboard 2
1. New Dashboard → 1200 × 800
2. Title: **"Risk Factor Deep-Dive"**
3. Arrange: Risk by Age on top, Mental Health + Shift Work on bottom
4. Add **Filter Actions**: click Dashboard → **Actions** → **Filter** → select source/target sheets so clicking on an age group filters the other charts

---

## Dashboard 3: Lifestyle Impact Explorer

### Sheet 3.1 — Caffeine vs Sleep Quality
1. Drag `Caffeine Mg Before Bed` to **Columns**
2. Drag `Sleep Quality Score` (AVG) to **Rows**
3. Add **Trend Line**: right-click chart → **Trend Lines** → **Show Trend Lines**
4. Color the bars by caffeine level (drag same field to Color)
5. Rename: **"Caffeine Impact"**

### Sheet 3.2 — Screen Time vs Quality
1. Create a calculated field `Screen Time Bin`:
   ```
   IF [Screen Time Before Bed Mins] <= 30 THEN "0-30 min"
   ELSEIF [Screen Time Before Bed Mins] <= 60 THEN "30-60 min"
   ELSEIF [Screen Time Before Bed Mins] <= 90 THEN "60-90 min"
   ELSEIF [Screen Time Before Bed Mins] <= 120 THEN "90-120 min"
   ELSE "120-180 min"
   END
   ```
2. Drag `Screen Time Bin` to **Columns**, `Sleep Quality Score` (AVG) to **Rows**
3. Add color gradient
4. Rename: **"Screen Time Impact"**

### Sheet 3.3 — Exercise Effect
1. Drag `Exercise Day` to **Columns** (rename: 0 = "No Exercise", 1 = "Exercise")
2. Drag `Sleep Quality Score` (AVG) to **Rows**
3. Add `Sleep Duration Hrs` (AVG) as second row (Dual Axis)
4. Rename: **"Exercise Effect"**

### Sheet 3.4 — Correlation Scatter
1. Drag `Sleep Quality Score` to **Columns**
2. Drag `Cognitive Performance Score` to **Rows**
3. Drag `Stress Score` to **Color** (continuous, Red-Green reversed)
4. Drag `Sleep Duration Hrs` to **Size**
5. Set Mark type to **Circle**, reduce opacity to 50%
6. Add Trend Line
7. Rename: **"Quality vs Cognition"**

### Assemble Dashboard 3
1. New Dashboard → 1200 × 800
2. Title: **"Lifestyle Impact Explorer"**
3. Add all 4 sheets in a 2×2 grid
4. Add **parameter controls** or **filters** for Gender, Age Group, Country to make it interactive

---

## Publishing to Tableau Public

1. Click **Server** → **Tableau Public** → **Save to Tableau Public As...**
2. Log in with your Tableau Public account
3. Name it: **"Sleep Health & Lifestyle Analysis"**
4. Click **Save**
5. Copy the URL from the browser — paste it into `tableau/README.md`

---

## Taking Screenshots for GitHub

1. After publishing, open each dashboard on Tableau Public
2. Press **Download** → **Image** (or use Windows Snipping Tool: Win + Shift + S)
3. Save as:
   - `tableau/screenshots/01_kpi_overview.png`
   - `tableau/screenshots/02_risk_analysis.png`
   - `tableau/screenshots/03_lifestyle_impact.png`
4. Commit and push these images to GitHub

---

## Pro Tips for Recruiters

- **Use consistent colors** across all 3 dashboards (e.g., green = healthy, red = severe)
- **Add tooltips**: hover over a mark → click **Tooltip** → customize what shows on hover
- **Use Dashboard Actions** (filter + highlight) to make dashboards interactive
- **Add your name** in a text box at the bottom of each dashboard
- **Use a clean layout** with clear titles — recruiters spend 10 seconds max per dashboard
