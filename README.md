# C# Project Maker

This is a simple Makefile that creates C# projects compatible with any OS / IDE / .NET core versions (that we know of).

# Testing the Project and the C# Project Maker

## To test the C# project 

1. Grab [the `solution_name.zip` file](https://github.com/csci-1301/C-Sharp-project-maker/files/13906926/solution_name.zip) from our [release](https://github.com/csci-1301/C-Sharp-project-maker/releases),
2. Extract `solution_name.zip`,
4. Open `solution_name/solution_name.sln` with your favorite IDE,
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

To run the example, 

0. (Download or clone this program.)
1. Run

    ```
    make build/solution_name.zip
    ```

2. Look into the `build/` folder that was created for a `solution_name.zip` file.
3. Extract `solution_name.zip`,
4. Open `solution_name/solution_name.sln` with your favorite IDE,
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
- Create a `Program.cs` file (mandatory), and, possibly, one (or multiple) class files (called, for instance, `Class1.cs`, `Class2.cs`, etc., [except that you can't actually use those names](https://github.com/csci-1301/C-Sharp-project-maker/issues/1)).
- Run 
    
    ```
    make build/sol-xx.zip
    ```
- Check that the file `build/sol-xx.zip` was correctly created and can be opened with your IDE.

# Comments

The makefile is actually very simple, it creates the `.sln`, `.csproj` and `.cs` files to obtain this structure:

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

This is for very simple projects (such as the ones used for pedagogical purposes in [this introduction to programming](https://csci-1301.github.io/) course), with portability in mind.

Despite the following source and discussions:

- <https://learn.microsoft.com/en-us/visualstudio/ide/solutions-and-projects-in-visual-studio?view=vs-2022>,
- <https://stackoverflow.com/questions/2736260/programmatically-generate-visual-studio-solution>,
- <https://learn.microsoft.com/en-us/dotnet/core/porting/project-structure>,

there are no specification (that we know of) for C# projects, hence the need for this type of approach.

# Tested on

We confirm that the solution created using this project work on the following:

OS | IDE | IDE Version | .Net Core SDK Version | .Net Core Runtime Version
--- | --- | --- | --- | --- 
Debian 12 | MonoDevelop | 7.8.4 | 8.0.10 | 8.0.0 
Debian 12 | JetBrains Rider | 2023.3.2 | 8.0.10 | 8.0.0 
MacOs Sonoma (14.1.1) | Visual Studio for Mac | 2022 | 7.0.308 | 7.0.11

# Reporting Data

If your OS / IDE combination is not [presented above](#tested-on), we would appreciate it if you could contact us or open a merge request adding your information.
The command `dotnet --info` may give you the .Net Core SDK and .Net Core Runtime versions,  if not please refer to <https://learn.microsoft.com/en-us/dotnet/core/install/how-to-detect-installed-versions>. 
