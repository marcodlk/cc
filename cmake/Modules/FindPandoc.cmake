#
# cc - C Containers library
#
# cc is, per 17 USC § 101, a work of the U.S. Government and is not subject to
# copyright protection in the United States.
#
# DISTRIBUTION STATEMENT A.  Approved for public release; distribution is
# unlimited.  Granted clearance per 88ABW-2020-3430.
#

#[=======================================================================[.rst:
FindPandoc
----------

Locate the Pandoc markup file conversion utility.

Imported targets
^^^^^^^^^^^^^^^^

This module defines the following :prop_tgt:`IMPORTED` targets:

``Pandoc``
  The Pandoc executable, if found

Result variables
^^^^^^^^^^^^^^^^

This module defines the following variables:

``Pandoc_FOUND``
  True if the Pandoc utility was found
``Pandoc_EXECUTABLE``
  The path to the Pandoc executable

#]=======================================================================]

FIND_PROGRAM(Pandoc_EXECUTABLE NAMES pandoc)

IF(Pandoc_EXECUTABLE)
  EXECUTE_PROCESS(
      COMMAND "${Pandoc_EXECUTABLE}" --version
      OUTPUT_VARIABLE Pandoc_VERSION
      OUTPUT_STRIP_TRAILING_WHITESPACE
      RESULT_VARIABLE _)
  IF(_)
    MESSAGE(WARNING "Unable to determine pandoc version: ${_}")
  ELSE()
    STRING(REGEX MATCH
        "[0-9]+\.[0-9]+\.[0-9]+"
        Pandoc_VERSION
        "${Pandoc_VERSION}")
  ENDIF()
ENDIF()

INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(Pandoc
    REQUIRED_VARS Pandoc_EXECUTABLE
    VERSION_VAR Pandoc_VERSION)

IF(Pandoc_FOUND)
  IF(NOT TARGET Pandoc)
    ADD_EXECUTABLE(Pandoc IMPORTED GLOBAL)
    SET_TARGET_PROPERTIES(Pandoc PROPERTIES
        IMPORTED_LOCATION "${Pandoc_EXECUTABLE}")
  ENDIF()
ENDIF()
