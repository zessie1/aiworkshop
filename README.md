# AI Workshop - OpenEdge ABL Project

## Overview

This project demonstrates the ABL Business Entity Architecture pattern for OpenEdge applications. It includes examples of refactored legacy code using modern architectural patterns.

## Features

- **Business Entity Pattern**: Clean separation between UI, business logic, and data layers
- **Factory Pattern**: Singleton pattern for entity management
- **Dataset-Based Access**: Temp-tables for data transfer and change tracking
- **Validation Logic**: Centralized business rules with proper error handling

## Project Structure

```
src/
  business/
    CustomerEntity.cls    # Customer business entity
    ItemEntity.cls        # Item business entity  
    EntityFactory.cls     # Singleton factory for entities
    CustomerDataset.i     # Customer dataset definition
    ItemDataset.i         # Item dataset definition
  CustomerWin.w          # Customer UI window (refactored)
  ItemWin.w              # Item UI window (refactored)
doc/
  business-entity-pattern.md  # Architecture documentation
```

## Architecture

The project follows the Business Entity pattern:

1. **UI Layer** (.w files) - Handle user interface only
2. **Business Layer** (Entity classes) - Contain business logic and validation
3. **Data Layer** (Datasets) - Handle data transfer and change tracking
4. **Factory Layer** - Manage entity instances using Singleton pattern

## Getting Started

1. Clone this repository
2. Open the project in Progress Developer Studio
3. Compile the business classes
4. Run the UI windows to test functionality

## Documentation

See `doc/business-entity-pattern.md` for detailed architecture guidelines and migration strategies.

## License

This project is part of the AI Workshop for OpenEdge ABL development.