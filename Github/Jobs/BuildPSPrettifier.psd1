@{
    "runs-on" = "ubuntu-latest"    
    if = '${{ success() }}'
    steps = @(
        @{
            name = 'Check out repository'
            uses = 'actions/checkout@v2'
        }, 
        @{    
            name = 'Use Piecemeal'
            uses = 'StartAutomating/Piecemeal@main'
            id = 'Piecemeal'
        },
        'RunPipeScript',
        'RunEZOut',       
        'RunHelpOut'
    )
}