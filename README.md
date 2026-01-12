# C# Project Maker

This is a simple Makefile that creates C# projects compatible with any OS / IDE / .NET core versions (that we know of):

- One project uses the "v4.5.2" `TargetFrameworkVersion`,
- One project uses "net8.0" `TargetFramework`,
- One project uses "net9.0" `TargetFramework`,
- One project uses "net10.0" `TargetFramework`,
- One project uses "net8.0" `TargetFramework` and the `RollForward` to be forward-compatible.

The "8.0 `RollForward`" version should be the one used by default.

# Testing the Project and the C# Project Maker

## To test the C# projects

### For the v4.5.2 Version

1. Grab [the `solution_name_v4.5.2.zip` file](https://github.com/csci-1301/C-Sharp-project-maker/releases/download/1.0.4/solution_name_v4.5.2.zip) from our [release](https://github.com/csci-1301/C-Sharp-project-maker/releases),
2. Extract `solution_name_v4.5.2.zip`,
4. Open `solution_name/solution_name.sln` with your favorite IDE,
5. Make sure you can compile and execute `Program.cs`. Normally, the program should display
    
    ```
    10
    Hello from Class2
    ```

Please, open an issue if you cannot reproduce this behavior or if your IDE did not open correctly the project, or [report to us](#reporting-data) if your OS / IDE / .Net version combination is not [listed below](#tested-on).

### For the v8.0, v9.0, v10.0 and v8.0 `RollForward` Versions

1. Grab either

    - [the `solution_name_v8.0.zip` file](https://github.com/csci-1301/C-Sharp-project-maker/releases/download/1.0.4/solution_name_v8.0.zip) from our [release](https://github.com/csci-1301/C-Sharp-project-maker/releases),
    - [the `solution_name_v9.0.zip` file](https://github.com/csci-1301/C-Sharp-project-maker/releases/download/1.0.4/solution_name_v9.0.zip) from our [release](https://github.com/csci-1301/C-Sharp-project-maker/releases),
    - [the `solution_name_v10.0.zip` file](https://github.com/csci-1301/C-Sharp-project-maker/releases/download/1.0.4/solution_name_v10.0.zip) from our [release](https://github.com/csci-1301/C-Sharp-project-maker/releases),
    - [the `solution_name.zip` file](https://github.com/csci-1301/C-Sharp-project-maker/releases/download/1.0.4/solution_name.zip) from our [release](https://github.com/csci-1301/C-Sharp-project-maker/releases),
    
2. Extract the zip file you downloaded,
4. Open the `solution_name/project_name/` folder with your favorite IDE, or `cd` there with you terminal,
5. Make sure you can compile and execute `Program.cs`. Normally, the program should display
    
    ```
    10
    Hello from Class2
    ```

Please, open an issue if you cannot reproduce this behavior or if your IDE did not open correctly the project, or [report to us](#reporting-data) if your OS / IDE / .Net version combination is not [listed below](#tested-on).

## To create the C# project

### Pre-requisites

- Some basic knowledge of Makefile,
- [7zip](https://7-zip.org/),
- A Unix system (which can be a [Windows Subsystem for Linux](https://learn.microsoft.com/en-us/windows/wsl/about)),
- How to clone or download a repository.

Alternatively, you can simply clone this repository and have github's action produce the project for you, using [our workflow](https://github.com/csci-1301/C-Sharp-project-maker/blob/main/.github/workflows/makefile.yml).

### Creating a C# project and testing it

### For the v4.5.2 Version

To run the example, 

0. (Download or clone this program.)
1. Run

    ```
    make build/solution_name_v4.5.2.zip
    ```

2. Look into the `build/` folder that was created for a `solution_name_v4.5.2.zip` file.
3. Extract `solution_name_v4.5.2.zip`,
4. Open `solution_name/solution_name.sln` with your favorite IDE,
5. Make sure you can compile and execute `Program.cs`. Normally, the program should display
    
    ```
    10
    Hello from Class2
    ```

Please, open an issue if you cannot reproduce this behavior or if your IDE did not open correctly the project, or [report to us](#reporting-data) if your OS / IDE / .Net version combination is not [listed below](#tested-on).

### For the v8.0, v9.0, v10.0 and v8.0 `RollForward` Versions

To run the example, 

0. (Download or clone this program.)
1. Run one of the following, based on the version you are interested in:

    ```
    make build/solution_name_v8.0.zip
    make build/solution_name_v9.0.zip
    make build/solution_name_v10.0.zip
    make build/solution_name.zip
    ```

2. Look into the `build/` folder that was created for a `solution_name_v8.0.zip`, `solution_name_v9.0.zip`, `solution_name_v10.0.zip` or `solution_name.zip` file.
3. Extract the zip file,
4. Open the `solution_name/project_name/` folder with your favorite IDE, or `cd` there with you terminal,
5. Make sure you can compile and execute `Program.cs`. Normally, the program should display
    
    ```
    10
    Hello from Class2
    ```

Please, open an issue if you cannot reproduce this behavior or if your IDE did not open correctly the project, or [report to us](#reporting-data) if your OS / IDE / .Net version combination is not [listed below](#tested-on).

# Instructions to Create a New Project

To create a new project:

- Create a folder in `src/` and name it after the _solution_ (say, `sol-xx`),
- Create a folder in `src/sol-xx` and name it after the _project_ (say, `proj-yy`),
- Create a `Program.cs` file (mandatory), and, possibly, one (or multiple) class files (called, for instance, `Class1.cs`, `Class2.cs`, etc., ([yes, that would work](https://github.com/csci-1301/C-Sharp-project-maker/issues/1))).
- Run 
    
    ```
    make build/sol-xx_v4.5.2.zip
    ```
    
    or 
    
    
    ```
    make build/sol-xx_v8.0.zip
    ```
    
    or 
    
    ```
    make build/sol-xx_v9.0.zip
    ```
    
    or 
    
    ```
    make build/sol-xx_v10.0.zip
    ```

    or 
    
    ```
    make build/sol-xx.zip
    ```
    
    
- Check that the file `build/sol-xx_v4.5.2.zip`, `build/sol-xx_v8.0.zip`, `build/sol-xx_v9.0.zip`, `build/sol-xx_v10.0.zip` or  `build/sol-xx.zip`  was correctly created and can be opened with your IDE.

# Comments

The makefile is actually very simple, it creates the `.sln`, `.csproj` and `.cs` files to obtain this structure for the v4.5.2 framework,

```
 └───<Solution>
      ├── <Solution.sln>
      └── <Project>
           ├── <Project>.csproj
           ├── Properties
           │   └── AssemblyInfo.cs
           ├── Program.cs           
           └── <Class>.cs	     (Optional, can be repeated)
```

and only create the .csproj file for the v8.0 and higher frameworks.

This is for very simple projects (such as the ones used for pedagogical purposes in [this introduction to programming](https://princomp.github.io/) course), with portability in mind.

Despite the following sources and discussions:

- <https://learn.microsoft.com/en-us/visualstudio/ide/solutions-and-projects-in-visual-studio?view=vs-2022>,
- <https://stackoverflow.com/questions/2736260/programmatically-generate-visual-studio-solution>,
- <https://learn.microsoft.com/en-us/dotnet/core/porting/project-structure>,
- <https://learn.microsoft.com/en-us/visualstudio/msbuild/common-msbuild-project-properties>,
- <https://learn.microsoft.com/en-us/dotnet/core/project-sdk/msbuild-props>

there are no specification (that we know of) for C# projects that is stable through releases, hence the need for this type of approach.

# Tested on

We confirm that the solution created using this project work on the following:

Version | OS | IDE | IDE Version | .Net Core SDK Version | .Net Core Runtime Version
--- | --- | --- | --- | --- | --- 
4.5.2 | Debian 12 | MonoDevelop | 7.8.4 | 8.0.10 | 8.0.0 
4.5.2 | Debian 12 | JetBrains Rider | 2023.3.2 | 8.0.10 | 8.0.0 
4.5.2 | MacOs Sonoma (14.1.1) | Visual Studio for Mac | 2022 | 7.0.308 | 7.0.11
4.5.2 | Windows 11 | Visual Studio | 2022 | - | - 
4.5.2 | Windows 10 Entreprise (22h2) | Visual Studio | Entreprise 2019 | 5.0.302 | 5.0.8
8.0 | Windows 11 | Code | 1.108.0 | 8.0.416 | 8.0.22
9.0 | MacOs Darwin (26.2) | Code | n/a | 9.0.112 | 9.0.112 
9.0 | Debian 13 | Code | 1.108.0 | 9.0.308 | 9.0.11
10.0 | Debian 13 | Code | 1.108.0 | 10.0.101 | 10.0.1

# Reporting Data

If your OS / IDE combination is not [presented above](#tested-on), we would appreciate it if you could contact us or open a merge request adding your information.
The command `dotnet --info` may give you the .Net Core SDK and .Net Core Runtime versions, if not please refer to <https://learn.microsoft.com/en-us/dotnet/core/install/how-to-detect-installed-versions>. 
