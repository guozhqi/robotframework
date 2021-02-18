*** Settings ***
Documentation     Test that current Rebot can process output.xml files generated by old Robot's.
...               Used output.xml files have been generated by running
...               ``./rundevel.py atest/testdata/misc/`` in appropriate version control tag.
Test Template     Run Rebot And Validate Statistics
Resource          rebot_resource.robot

*** Test Cases ***
RF 3.2 compatibility
    rebot/output-3.2.2.xml    172    10

RF 4.0 compatibility
    rebot/output-4.0.xml      172    10

*** Keywords ***
Run Rebot And Validate Statistics
    [Arguments]    ${path}    ${passed}    ${failed}
    Run Rebot    ${EMPTY}    ${path}
    ${total}    ${passed}    ${failed} =    Evaluate    ${passed} + ${failed}, ${passed}, ${failed}
    Should Be Equal    ${SUITE.statistics.total}     ${total}
    Should Be Equal    ${SUITE.statistics.passed}    ${passed}
    Should Be Equal    ${SUITE.statistics.failed}    ${failed}