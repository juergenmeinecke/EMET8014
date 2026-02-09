Get Julia-ready!
=================

What are Julia and Jupyter?
----------------------------

Econometrics is all about using data to answer real-world economic questions. To do this well, we
need to be able to work with data—loading it, cleaning it, visualising it, and running statistical
analyses on it.

While you could do some of this in spreadsheets, modern econometric work involves datasets and
methods that quickly outgrow what Excel can handle. That's where coding comes in. 
We'll be doing all our coding in Julia. Don't worry if you've never coded before, we'll teach
everything from scratch.

What is `Julia <https://julialang.org>`_!? Well, Julia's awesome! Enough said.  The way we interact
with Julia is through so-called **Jupyter notebooks**. Our friends from `quantecon.org
<https://quantecon.org>`_ explain:

.. admonition:: What are Jupyter notebooks?

    Jupyter notebooks are one of the many possible ways to interact with Julia and the scientific
    libraries.

    They use a browser-based interface to Julia with

    * The ability to write and execute Julia commands.

    * Formatted output in the browser, including tables, figures, animation, etc.

    * The option to mix in formatted text and mathematical expressions.

    Because of these features, Jupyter is now a major player in the scientific computing ecosystem.

    (referenced from `here <https://python-programming.quantecon.org/getting_started.html#jupyter-notebooks>`_)
    where I swapped out all instances of "Python" with "Julia".

I hear you ask: Sounds awesome, but how in the world do I get started with Jupyter!? 

We strongly recommend that you use Jupyter from inside VS Code! What is VS Code? VS Code is a free,
open-source code editor.

This guide will walk you through installing Julia and setting up Visual Studio Code (VSCode) as your
development environment for this course. You'll learn how to work with Jupyter notebooks in VSCode,
which is how you'll complete all labs and assignments.


Installing Julia
----------------

Step 1: Download Julia
~~~~~~~~~~~~~~~~~~~~~~

1. Go to the official Julia downloads page: https://julialang.org/downloads/
2. Download the **Current stable release** for your operating system
   
   - We recommend Julia 1.10 or newer (as of 2025, Julia 1.12 is current)
   - Choose the appropriate installer for your system:
   
     - **Windows**: Download the 64-bit installer (``.exe`` file)
     - **macOS**: Download the ``.dmg`` file (Intel or Apple Silicon depending on your Mac)

.. note::
   If you're unsure whether your system is 32-bit or 64-bit, it's almost certainly 64-bit if your computer was made after 2010.
   
   **Linux users**: Download the generic binary and follow the standard Julia installation procedure for your distribution.

Step 2: Install Julia
~~~~~~~~~~~~~~~~~~~~~

**Windows**

1. Run the downloaded ``.exe`` installer
2. Follow the installation wizard
3. **Important**: Check the box "Add Julia to PATH" during installation
4. Complete the installation

**macOS**

1. Open the downloaded ``.dmg`` file
2. Drag the Julia app to your Applications folder
3. To add Julia to your PATH:
   
   a. Open Terminal
   b. Run this command:
   
      .. code-block:: bash
      
         sudo mkdir -p /usr/local/bin
         sudo ln -s /Applications/Julia-1.12.app/Contents/Resources/julia/bin/julia /usr/local/bin/julia
   
   c. Enter your password when prompted

.. note::
   Replace ``Julia-1.12`` with your actual Julia version number.

Step 3: Verify Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Open a terminal (Command Prompt on Windows, Terminal on macOS/Linux) and type:

.. code-block:: bash

   julia --version

You should see output like:

.. code-block:: text

   julia version 1.12.0

If you see this, Julia is successfully installed!


Setting Up Visual Studio Code
------------------------------

**Step 1: Install VSCode**

1. Download VSCode from: https://code.visualstudio.com/
2. Install it following the standard process for your operating system

**Step 2: Install Required Extensions**

1. Open VSCode
2. Click on the Extensions icon in the left sidebar (or press ``Ctrl+Shift+X`` / ``Cmd+Shift+X``)
3. Install these two extensions:
   
   a. **Julia** (by julialang) - The official Julia language extension
   b. **Jupyter** (by Microsoft) - For notebook support


**Step 3: Configure the Julia Extension**

The extension should automatically detect your Julia installation. To verify:

1. Open VSCode settings (``Ctrl+,`` / ``Cmd+,``)
2. Search for "julia executable"
3. Ensure "Julia: Executable Path" points to your Julia binary
   
   - Usually auto-detected
   - If not, set it manually:
   
     - **Windows**: ``C:\Users\YourName\AppData\Local\Programs\Julia-1.12.0\bin\julia.exe``
     - **macOS**: ``/Applications/Julia-1.12.app/Contents/Resources/julia/bin/julia``

**Step 4: Working with Jupyter Notebooks in VSCode**

This is the primary way you'll work in this course:

1. **Open or create a notebook**:
   
   - File → New File → Jupyter Notebook
   - Or open an existing ``.ipynb`` file from the course materials
   - Save with ``.ipynb`` extension

2. **Select the Julia kernel**:
   
   - Click "Select Kernel" in the top-right corner of the notebook
   - Choose "Julia 1.12" (or your installed version)
   - VSCode will start a Julia session in the background

3. **Working with cells**:
   
   - **Add a code cell**: Click "+ Code" button or press ``B`` (when not editing)
   - **Add a markdown cell**: Click "+ Markdown" or press ``M`` (when not editing)
   - **Run a cell**: Click the play button (▶) or press ``Shift+Enter``
   - **Run and move to next**: ``Shift+Enter``
   - **Run without moving**: ``Ctrl+Enter`` / ``Cmd+Enter``

That's it! You're ready to start working with Julia notebooks.


Installing Julia Packages
-------------------------

Julia has a built-in package manager that makes it easy to install and manage packages. This guide covers the essential commands you'll need for this course.

Basic Package Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~~

The easiest way to install packages is through Julia's package manager. 

1. Start Julia by typing ``julia`` in your terminal
2. Press the ``]`` key to enter package mode (the prompt will change from ``julia>`` to ``pkg>``)
3. Type ``add PackageName`` to install a package
4. Press backspace to return to normal Julia mode

Example:

.. code-block:: julia

   julia> ]  # Press ] to enter pkg mode
   
   (@v1.12) pkg> add Distributions
   (@v1.12) pkg> add Plots
   (@v1.12) pkg> add Optim
   
   # Press backspace to exit pkg mode
   julia>

Required Packages for This Course
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For EMET8014, you'll need the following packages:

**Core Packages**

.. code-block:: julia

   pkg> add Distributions      # Statistical distributions
   pkg> add Plots              # Data visualization
   pkg> add StatsPlots         # Statistical plotting extensions
   pkg> add Optim              # Optimization algorithms
   pkg> add Roots              # Root finding
   pkg> add LinearAlgebra      # Linear algebra (built-in, usually pre-installed)
   pkg> add Statistics         # Basic statistics (built-in, usually pre-installed)
   pkg> add DelimitedFiles     # Reading CSV files (built-in)
   pkg> add Random             # Random number generation (built-in)

Install them all at once like so:

.. code-block:: julia

   pkg> add Distributions Plots StatsPlots Optim Roots 

.. note::
   The built-in packages (``LinearAlgebra``, ``Statistics``, ``DelimitedFiles``, ``Random``) are part of Julia's standard library and typically don't need explicit installation. However, if you encounter issues, you can still use ``pkg> add ...`` to ensure they're available.

Using Packages
~~~~~~~~~~~~~~

After installation, you need to load packages before using them in your code:

.. code-block:: julia

   using Distributions
   using Plots
   using LinearAlgebra

The first time you use a package in a Julia session, it will take a moment to compile. Subsequent uses in the same session will be faster.



Working with Jupyter Notebooks
-------------------------------

If you're using Jupyter notebooks (recommended for this course), you can install packages directly
in a notebook cell:

.. code-block:: julia

   using Pkg
   Pkg.add("Distributions")

Or use package mode by starting a cell with ``]``:

.. code-block:: julia

   ] add Distributions

.. warning::

   When using package mode in Jupyter, you may need to restart the kernel after installing new
   packages for them to be available.

.. note::

   There are other ways to run Julia and Jupyter notebooks that we won't cover here, including:

   - `Google Colab <https://colab.research.google.com>`_ -- free cloud-based Jupyter notebooks (limited Julia support, requires setup)
   - `Anaconda <https://www.anaconda.com>`_ -- popular Python distribution that includes Jupyter (requires IJulia package for Julia kernel)
   - `Binder <https://mybinder.org>`_ -- launches Jupyter notebooks directly from a GitHub repository
   - `GitHub Codespaces <https://github.com/features/codespaces>`_ -- a full development environment in the cloud
   - `JupyterHub <https://jupyter.org/hub>`_ -- often used by universities to provide shared Jupyter servers
   - `JupyterLab <https://jupyterlab.readthedocs.io>`_ -- a more advanced interface (included with Anaconda)

   Feel free to explore these if you're curious, but VSCode will serve you well for this course.

