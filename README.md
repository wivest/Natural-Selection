# Natural Selection

Sumilation of natural selection, built inside [**Godot Engine 4**](https://godotengine.org).

![Natural selection](screenshot.png)

## Features

-   Simulating creatures adapting to environment over time
-   Fully customizable simulation parameters
-   Live chart tracking
-   Chart settings including simulation speed

### Rules

Simulation consists of creatures and food. Creatures eat food, receive energy and lay eggs, which turn into new creatures. Every creature have a set of genes: Speed, View Radius and Hatching Time. Speed controls movement, View Radius controls how far creature can see food and Hatching Time defines egg's life length. Creature moves towards closest food item with Speed, if there is no food inside its circle view, it chooses random target on view's circumference. Eaten food refills creature's energy, which is consumed based on genes values. When creature has enough energy, it lays an egg with a slightly changed genes combination, that goes to children. This results in a natural selection, because only best adapted creatures survive.

## Getting started

### Prerequisites

To run the project you need to install **Godot Engine**. Minimal required version is **4.x**. The engine can be downloaded from various resources, including [official website](https://godotengine.org/download). C# support is not required.

> [!TIP]
> Specific version **4.2.1** was used in this project. Downloading it can help avoiding further issues.

### Repository

To get a local copy of repository open terminal and execute `git clone` command:

```
git clone https://github.com/wivest/Natural-Selection.git
```

Or download `.zip` [archive](https://github.com/wivest/Natural-Selection/archive/refs/heads/main.zip) and extract files.

### Run the project

[Import](https://docs.godotengine.org/en/stable/tutorials/editor/project_manager.html#opening-and-importing-projects) project in Godot _Project Manger_.

> [!NOTE]
> Project folder is most likely named either `Natural-Selection` or `Natural-Selection-main`

To launch project you need to select it and click `Run` button.

## Settings

In the settings tab you can edit parameters to customize simulation.

### Food

| Parameter     | Meaning                                       |
| ------------- | --------------------------------------------- |
| `On start`    | Amount of food spawned when simulation starts |
| `Spawn rate`  | Amount of food spawned every second           |
| `Food energy` | Energy contained inside single food item      |

### Creature

| Parameter             | Meaning                                            |
| --------------------- | -------------------------------------------------- |
| `On start`            | Amount of creatures spawned when simulation starts |
| `Color speed minimum` | Bottom treshhold of color gradient                 |
| `Color speed maximum` | Top treshhold of color gradient                    |

### Energy

| Parameter              | Meaning                                                      |
| ---------------------- | ------------------------------------------------------------ |
| `When born`            | Energy every creature has on birth (and loses on egg laying) |
| `Division lower bound` | Treshhold after which creature will lay egg                  |

### Genes

Every gene has `Energy per second` parameters in the following form:

```
MULTIPLIER * value ^ POWER
```

| Parameter    | Meaning                                                               |
| ------------ | --------------------------------------------------------------------- |
| `MULTIPLIER` | Energy consumed by this gene is multiplied by this number             |
| `POWER`      | Energy consumed is equal to gene current value to the power of number |
| `Default`    | Default gene value when simulation starts                             |
