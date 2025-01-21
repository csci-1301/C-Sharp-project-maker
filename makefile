default: build/solution_name.zip

clean: 
	rm -rf build/
	rm -rf src/*/*.sln
	rm -rf src/*/*/Properties src/*/*/bin src/*/*/obj
	rm -rf src/*/*/*.csproj

build/%.zip: src/%/*/*.cs
# The structure of an archive is as follows:
# └───<Solution>	 	     $(notdir $*)
#      ├── <Solution.sln>	     $(dir $(patsubst %/,%,$(dir $<)))/$(notdir $*).sln
#      └── <Project>                 $(dir $<)
#           ├── <Project>.csproj     $(dir $<)$(notdir $(patsubst %/,%,$(dir $<))).csproj 
#           ├── Properties           $(dir $<)Properties 
#           │   └── AssemblyInfo.cs  $(dir $<)Properties/AssemblyInfo.cs
#           ├── Program.cs           
#           └── <Class>.cs	     (Optional, can be repeated)
# We will also use the following:
# $(notdir $*) # Name of Solution
# $(notdir $(patsubst %/,%,$(dir $<))) # Name of Project
# $@ # Name of target, the zip file
# $(dir $<)/Program.cs # Path to Program.cs
# grep -oP '(((internal)|(public)|(private)|(protected)|(sealed)|(abstract)|(static))?[\s\r\n\t]+){0,2}class[\s]+\K([[:alnum:]]|_)*[\s\S]' $(dir $<)/Program.cs # Name of the class in Program.cs
#
# We start by creating the required Properties directory:
	@mkdir -p build/ # Create build/ repository if it doesn't exist already (-p)
	@mkdir -p $(dir $<)Properties 
# We create the .sln file,
# The new lines have to be escaped with \n:
	@(printf '\nMicrosoft Visual Studio Solution File, Format Version 12.00\n# Visual Studio 14\nVisualStudioVersion = 14.0.25420.1\nMinimumVisualStudioVersion = 10.0.40219.1\nProject("{FAE04EC0-301F-11D3-BF4B-00C04F79EFBC}") = "$(notdir $(patsubst %/,%,$(dir $<)))", "$(notdir $(patsubst %/,%,$(dir $<)))\\$(notdir $(patsubst %/,%,$(dir $<))).csproj", "{C579075D-4630-47FA-9BE4-0E3E51DDFEA5}"\nEndProject\nGlobal\n	GlobalSection(SolutionConfigurationPlatforms) = preSolution\n		Debug|Any CPU = Debug|Any CPU\n		Release|Any CPU = Release|Any CPU\n	EndGlobalSection\n	GlobalSection(ProjectConfigurationPlatforms) = postSolution\n		{C579075D-4630-47FA-9BE4-0E3E51DDFEA5}.Debug|Any CPU.ActiveCfg = Debug|Any CPU\n		{C579075D-4630-47FA-9BE4-0E3E51DDFEA5}.Debug|Any CPU.Build.0 = Debug|Any CPU\n		{C579075D-4630-47FA-9BE4-0E3E51DDFEA5}.Release|Any CPU.ActiveCfg = Release|Any CPU\n		{C579075D-4630-47FA-9BE4-0E3E51DDFEA5}.Release|Any CPU.Build.0 = Release|Any CPU\n	EndGlobalSection\n	GlobalSection(SolutionProperties) = preSolution\n		HideSolutionNode = FALSE\n	EndGlobalSection\nEndGlobal\n') > $(dir $(patsubst %/,%,$(dir $<)))/$(notdir $*).sln
# We create the .csproj file.
# New lines are escaped as \n
# Single quotes are escaped as '\''
# $ are escaped as $$ (if they are *not* to be interpreted, i.e escape $(MSBuildToolsVersion) but not $(notdir $*)
# and \ are escaped as \\
# The additional difficulty is that we want the csproj to include all the .cs files in the <Solution> folder
# (so, not only the Program.cs, but also possible (multiple) <Class>.cs).
# We create the part in five parts: 
#     1. The initial set-up,
#     2. We insert the name of the class in Program.cs to be the default startup object,
#     3. We continue with the standard template of the file,
#     4. Then, we append "<Compile Include="<name of the cs file>" />" for each cs file in the <Solution> folder,
#     5. Finally, we append the required closing to the file.
# Apparently, another way would be to use wildcards (cf. https://stackoverflow.com/a/9438419)
	@(printf '<?xml version="1.0" encoding="utf-8"?>\n<Project ToolsVersion="14.0" DefaultTargets="Build" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">\n  <Import Project="$$(MSBuildExtensionsPath)\$$(MSBuildToolsVersion)\Microsoft.Common.props" Condition="Exists('\''$$(MSBuildExtensionsPath)\$$(MSBuildToolsVersion)\Microsoft.Common.props'\'')" />\n  <PropertyGroup>\n\t<StartAction>Project</StartAction>\n\t<ExternalConsole>true</ExternalConsole>\n\t<Configuration Condition=" '\''$$(Configuration)'\'' == '\'''\'' ">Debug</Configuration>\n\t<Platform Condition=" '\''$$(Platform)'\'' == '\'''\'' ">AnyCPU</Platform>\n\t<ProjectGuid>{C579075D-4630-47FA-9BE4-0E3E51DDFEA5}</ProjectGuid>\n\t<OutputType>Exe</OutputType>\n\t<AppDesignerFolder>Properties</AppDesignerFolder>\n\t<RootNamespace>$(notdir $*)</RootNamespace>\n\t<AssemblyName>$(notdir $*)</AssemblyName>\n\t<TargetFrameworkVersion>v4.5.2</TargetFrameworkVersion>\n\t<FileAlignment>512</FileAlignment>\n\t<AutoGenerateBindingRedirects>true</AutoGenerateBindingRedirects>\n  </PropertyGroup>\n  <PropertyGroup Condition=" '\''$$(Configuration)|$$(Platform)'\'' == '\''Debug|AnyCPU'\'' ">\n\t<PlatformTarget>AnyCPU</PlatformTarget>\n\t<DebugSymbols>true</DebugSymbols>\n\t<DebugType>full</DebugType>\n\t<Optimize>false</Optimize>\n\t<OutputPath>bin\Debug\</OutputPath>\n\t<DefineConstants>DEBUG;TRACE</DefineConstants>\n\t<ErrorReport>prompt</ErrorReport>\n\t<WarningLevel>4</WarningLevel>\n  </PropertyGroup>\n  <PropertyGroup Condition=" '\''$$(Configuration)|$$(Platform)'\'' == '\''Release|AnyCPU'\'' ">\n\t<PlatformTarget>AnyCPU</PlatformTarget>\n\t<DebugType>pdbonly</DebugType>\n\t<Optimize>true</Optimize>\n\t<OutputPath>bin\Release\</OutputPath>\n\t<DefineConstants>TRACE</DefineConstants>\n\t<ErrorReport>prompt</ErrorReport>\n\t<WarningLevel>4</WarningLevel>\n  </PropertyGroup>\n  <PropertyGroup>\n\t<StartupObject>\n\t\t') > $(dir $<)$(notdir $(patsubst %/,%,$(dir $<))).csproj; \
# The following grep the name of the class in Program.cs,
# following the official syntax given at 
# https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/language-specification/classes#1521-general
# class_declaration
#    : attributes? class_modifier* 'partial'? 'class' identifier
#        type_parameter_list? class_base? type_parameter_constraints_clause*
#        class_body ';'?
#    ;
# Inspired by the regular expression given at 
# https://stackoverflow.com/a/19858777
	@grep -oP '(((internal)|(public)|(private)|(protected)|(sealed)|(abstract)|(static))?[\s\r\n\t]+){0,2}class[\s]+\K([[:alnum:]]|_)*[\s\S]' $(dir $<)/Program.cs >> $(dir $<)$(notdir $(patsubst %/,%,$(dir $<))).csproj \
	&& (printf '\t</StartupObject>\n  </PropertyGroup>\n\t<ItemGroup>\n\t<Reference Include="System" />\n\t<Reference Include="System.Core" />\n\t<Reference Include="System.Xml.Linq" />\n\t<Reference Include="System.Data.DataSetExtensions" />\n\t<Reference Include="Microsoft.CSharp" />\n\t<Reference Include="System.Data" />\n\t<Reference Include="System.Net.Http" />\n\t<Reference Include="System.Xml" />\n  </ItemGroup>\n  <ItemGroup>\n') >> $(dir $<)$(notdir $(patsubst %/,%,$(dir $<))).csproj \
	&& for fileA in $(dir $<)*.cs; do \
				printf '\t<Compile Include="'$$(basename $${fileA})'" />\n' >> $(dir $<)$(notdir $(patsubst %/,%,$(dir $<))).csproj ; \
			done;  \
	(printf  '\t<Compile Include="Properties\AssemblyInfo.cs" />\n  </ItemGroup>\n  <Import Project="$$(MSBuildToolsPath)\Microsoft.CSharp.targets" />\n</Project>\n') >> $(dir $<)$(notdir $(patsubst %/,%,$(dir $<))).csproj \
# We create the Properties\AssemblyInfo.cs file, but note that it can be empty.
	@touch $(dir $<)Properties/AssemblyInfo.cs
# Finally, we can zip the folder:
	@cd $(dir $(patsubst %/,%,$(dir $<)))../ && 7z -bso0 -bsp0 a ../$@ $(notdir $*)*  -xr\!.vs -xr\!.directory
# We compress (silently, thanks to the -bso0 -bsp0 options) the folder containing the sln and the folder containing the csproj and the code
# But we exclude the .vs folder and .directory file
