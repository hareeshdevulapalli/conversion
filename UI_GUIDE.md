# User Interface Guide

## 📱 App Layout

The app features a clean, minimalist layout with centered labels and underlined inputs:

```
┌─────────────────────────────────────┐
│  Measures Converter (Blue Header)  │
└─────────────────────────────────────┘

          Value (dark gray)
          100 (blue)
          ___________________

          From (dark gray)
          Meters (m) (blue) ▼
          ___________________

          To (dark gray)
          Feet (ft) (blue) ▼
          ___________________

            [ Convert ]

   100.0 meters are 328.084 feet
          (dark gray)
```

## 🔄 User Flow

### Step-by-Step Process

1. **Enter Value**
   - Type any numeric value (decimals allowed)
   - Text appears in blue
   - Required to enable Convert button

2. **Select From Unit**
   - Starts with "None" selected
   - Choose any unit from the full list
   - All categories available initially

3. **Select To Unit**
   - Starts with "None" selected
   - **Smart Filtering**: Only shows units from the same category as "From"
   - If "From" is "None", shows all units
   - Example: Select "Meters" in From → To dropdown shows only Distance units

4. **Click Convert Button**
   - Button enabled only when value is entered AND both units are selected
   - Performs conversion on click

5. **View Result**
   - Result appears below in natural language
   - Format: "X unit_from are Y unit_to"
   - Example: "100.0 meters are 328.084 feet"
   - Displayed in dark gray

## 🎨 UI Components

### 1. Header (App Bar)
- **Text**: "Measures Converter"
- **Background**: Blue (`Colors.blue`)
- **Text Color**: White
- **Style**: Bold, centered

### 2. Value Input
- **Label**: "Value" (dark gray, size 16, centered)
- **Input Style**: Blue text, size 16
- **Border**: Bottom border only (underline)
- **Validation**: Numbers and decimals only

### 3. From Unit Selector
- **Label**: "From" (dark gray, size 16, centered)
- **Selected Value**: Blue text, size 16
- **Border**: Bottom border only (underline)
- **Options**: 
  - "None" (default)
  - All units from all categories
- **Max Height**: 300px (scrollable)

### 4. To Unit Selector
- **Label**: "To" (dark gray, size 16, centered)
- **Selected Value**: Blue text, size 16
- **Border**: Bottom border only (underline)
- **Options**: 
  - "None" (default)
  - Filtered by "From" unit category
  - All units if "From" is "None"
- **Max Height**: 300px (scrollable)

### 5. Convert Button
- **Text**: "Convert"
- **Style**: Default Material elevated button
- **Position**: Centered
- **State**: Disabled until value + both units selected

### 6. Result Display
- **Text**: Natural language result
- **Color**: Dark gray (`Colors.grey[700]`)
- **Size**: 16px
- **Alignment**: Center

## 🎯 Smart Category Filtering

### How It Works

1. **Initial State**
   - From: "None" → To shows all units
   
2. **Distance Selected**
   - From: "Meters" → To shows only: Miles, Kilometers, Meters, Feet, Inches, Yards, Centimeters
   
3. **Weight Selected**
   - From: "Kilograms" → To shows only: Pounds, Kilograms, Ounces, Grams, Milligrams, Tons, Metric Tons
   
4. **Temperature Selected**
   - From: "Celsius" → To shows only: Fahrenheit, Celsius, Kelvin
   
5. **Volume Selected**
   - From: "Liters" → To shows only: Gallons, Liters, Milliliters, Cups, Fluid Ounces, Pints, Quarts

### Category Auto-Switching

If you change "From" to a different category:
- "To" automatically resets to "None"
- New filtered list appears
- Prevents invalid conversions

## 📝 Result Format Examples

### Distance
```
100.0 meters are 328.084 feet
1.0 mile is 1.609 kilometers
50.0 inches are 127.0 centimeters
```

### Weight
```
10.0 pounds are 4.536 kilograms
1.0 kilogram is 2.205 pounds
500.0 grams are 17.637 ounces
```

### Temperature
```
32.0 fahrenheit are 0.0 celsius
100.0 celsius are 212.0 fahrenheit
0.0 kelvin are -273.15 celsius
```

### Volume
```
1.0 gallon is 3.785 liters
500.0 milliliters are 2.113 cups
2.0 quarts are 1.893 liters
```

## 🎨 Color Scheme

### Colors
- **Header Background**: Blue (`Colors.blue`)
- **Header Text**: White
- **Labels**: Dark Gray (`Colors.grey[700]`)
- **Input/Dropdown Values**: Blue (`Colors.blue`)
- **Result Text**: Dark Gray (`Colors.grey[700]`)
- **Borders**: Default underline color

### Typography
- **Header**: Bold, white
- **Labels**: Regular, size 16, dark gray
- **Values**: Regular, size 16, blue
- **Result**: Regular, size 16, dark gray

## ✨ UI Design Principles

### Minimalism
- Only essential elements visible
- No cards, no extra borders
- Simple underlines for inputs
- Centered labels for clarity

### Consistency
- All labels same size and color
- All values same size and color
- Uniform spacing throughout

### User Guidance
- Disabled button prevents errors
- Smart filtering prevents invalid conversions
- Natural language results are easy to understand

## 📐 Layout Details

```
ConversionPage (Scaffold)
  ├─ AppBar (Blue)
  └─ Body (SingleChildScrollView)
      └─ Padding (16px)
          └─ Column (stretched)
              ├─ ValueInput (centered label, underlined input)
              ├─ SizedBox (16px)
              ├─ UnitSelector From (centered label, underlined dropdown)
              ├─ SizedBox (16px)
              ├─ UnitSelector To (centered label, underlined dropdown)
              ├─ SizedBox (24px)
              ├─ Center (Convert button)
              ├─ SizedBox (24px)
              └─ ResultDisplay (centered text)
```

## 🎓 User Experience Features

### Good Practices
✅ Smart category filtering prevents errors
✅ Disabled states guide user actions
✅ Natural language results
✅ Consistent color coding
✅ Centered labels for symmetry
✅ Limited dropdown height for usability

### Accessibility
✅ Sufficient color contrast
✅ Clear button labels
✅ Readable font sizes (16px)
✅ Proper spacing
✅ Intuitive flow
