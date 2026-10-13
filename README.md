# CAMduct-Master-Script

## Overview

The **CAMduct Master Script** is a centralized script used to automate and standardize item properties, connector assignments, and other repetitive tasks within Autodesk Fabrication CAMduct.

The purpose of this script is to improve fabrication consistency, reduce manual corrections, and streamline shop drawing and fabrication workflows.

## Features

- **Automated Connector Assignment** — Assign default connector types based on item properties and configured rules.
- **Item-Specific Logic** — Apply different rules to individual item types using item identifiers such as `Item.CID`.
- **Default Value Handling** — Detect unassigned connector values and replace them with specified defaults.
- **Conditional Processing** — Apply changes only when an item meets the conditions defined in the script.
- **Debugging Support** — Use `DEBUG` statements to inspect values and troubleshoot script behavior.
- **Centralized Management** — Maintain related CAMduct scripting rules in one organized location.

## Requirements

- Autodesk Fabrication CAMduct
- Access to the CAMduct scripting environment
- Knowledge of CAMduct item properties and connector definitions
- A backup of the original script before making changes

> **Note:** Supported syntax, properties, and update behavior depend on the CAMduct scripting environment and version.

## Script Structure

The master script should be organized into clearly defined sections.

### 1. Item Identification

Use item properties to determine which rules should execute.

Example:

```vb
Select Item.CID
    Case 53
        ' Connector rules for this item type
End Select
```

### 2. Connector Defaults

Check whether a connector is unassigned before applying a default value.

Example:

```vb
If Item.Connector[1].Value = "None" Then
    Item.Connector[1].Value = "SE Collar"
End If

If Item.Connector[2].Value = "None" Then
    Item.Connector[2].Value = "SE Collar"
End If

If Item.Connector[3].Value = "None" Then
    Item.Connector[3].Value = "SE"
End If
```

These assignments are examples of the intended rules. Verify that the connector changes persist when the item is updated in CAMduct.

### 3. Debugging

Use `DEBUG` statements to inspect values before and after a change.

Example:

```vb
DEBUG Item.Connector[1].Value

If Item.Connector[1].Value = "None" Then
    Item.Connector[1].Value = "SE Collar"
End If

DEBUG Item.Connector[1].Value
```

Debugging helps identify whether a condition is being met and whether a property changes during script execution.

### 4. Item Updates

Use `Item.Update()` only where appropriate for the script's execution context.

**Important:** If connector values revert after an update, investigate whether CAMduct is recalculating the item, restoring values from its configuration, or applying other rules that override the changes. Confirm the correct update sequence before adding update calls throughout the script.

## Adding New Rules

When adding a new item-specific rule:

1. Identify the item's `Item.CID`.
2. Determine which properties or connectors need to change.
3. Define the conditions under which changes should occur.
4. Preserve existing connector types that should not be overwritten.
5. Add debugging statements while testing.
6. Verify the final values in CAMduct after the item updates.
7. Document the new rule in the change log.

## Coding Standards

To keep the master script maintainable:

- Use clear comments to explain each rule.
- Group related logic by item type or function.
- Avoid duplicating the same logic unnecessarily.
- Use exact connector names and property values.
- Test changes on representative items before deployment.
- Preserve existing behavior unless a change is intentional.
- Remove temporary debugging statements when they are no longer needed.
- Maintain a backup before modifying production scripts.

## Troubleshooting

| Issue | What to check |
|---|---|
| Connector does not change | Verify the connector index, property value, and condition. |
| Condition does not execute | Check the item identifier and exact text being compared. |
| Connector changes in debugging but reverts | Investigate item updates, recalculation, and other rules that may overwrite the value. |
| Default applies to the wrong connector | Confirm the connector index and assignment. |
| Script produces unexpected results | Test one rule at a time and inspect values with `DEBUG`. |
| Script does not run for an item | Verify the item's `Item.CID` and the script's execution context. |

## Testing Procedure

Before deploying script changes:

- [ ] Back up the current master script.
- [ ] Test each affected item type.
- [ ] Test items with connector values set to `None`.
- [ ] Test items with existing connector assignments.
- [ ] Confirm special connector types are preserved where required.
- [ ] Verify connector values after `Item.Update()`.
- [ ] Confirm unrelated item properties remain unchanged.
- [ ] Document the results and update the change log.

## Change Log

| Version | Date | Description |
|---|---|---|
| 1.0 | YYYY-MM-DD | Initial master script documentation. |
| 1.1 | YYYY-MM-DD | Describe subsequent changes here. |

## Maintenance

Update this README whenever new item types, connector rules, or automation features are added.

Keep the README alongside the master script so that future edits can be understood, tested, and maintained consistently.

---

**Project:** CAMduct Master Script  
**Purpose:** Standardize and automate CAMduct scripting tasks  
**Status:** Update as features are implemented and verified  
**Maintainer:** [Name or Team]
