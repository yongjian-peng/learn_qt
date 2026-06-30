cmake_minimum_required(VERSION 3.21)

project(QtLeanLesson VERSION 0.1.0 LANGUAGES CXX)

# 中文注释：把 exe 和 dll 输出到 build/bin，运行时路径更清楚。
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml Quick QuickControls2 Test)

add_executable(qt_lean
    src/main.cpp
    qml/qml.qrc
)

target_link_libraries(qt_lean PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
    Qt6::QuickControls2
)

set_target_properties(qt_lean PROPERTIES
    WIN32_EXECUTABLE TRUE
)

if(WIN32)
     find_program(WINDEPLOYQT_EXECUTABLE
        NAMES windeployqt.exe
        HINTS "${Qt6_DIR}/../../../bin"
        REQUIRED
    )
    
    add_custom_command(TARGET qt_lean POST_BUILD
        COMMAND Qt6::windeployqt --no-translations
            --qmldir ${CMAKE_CURRENT_SOURCE_DIR}/qml
            $<TARGET_FILE:qt_lean>
        COMMENT "Deploying Qt runtime for qt_lean"
    )
endif()

enable_testing()

add_executable(qt_lean_tests
    tests/test_smoke.cpp
)

add_dependencies(qt_lean_tests qt_lean)

target_link_libraries(qt_lean_tests PRIVATE
    Qt6::Core
    Qt6::Test
)

target_compile_definitions(qt_lean_tests PRIVATE
    TEST_SOURCE_DIR="${CMAKE_CURRENT_SOURCE_DIR}"
    TEST_BINARY_DIR="${CMAKE_BINARY_DIR}"
)

add_test(NAME qt_lean_tests COMMAND qt_lean_tests)
