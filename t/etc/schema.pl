{
    'schema_class' => 'Lecstor::Schema',
    'connect_info' => ['dbi:SQLite:dbname=test.db','',''],
    'fixture_sets' => {
        'basic' => [
            'ActionType' => [
                ['name'],
                ['login'],
                ['login fail'],
                ['register'],
                ['register fail'],
                ['view product'],
            ],
        ],
        'login' => [
            'LoginRole' => [
                ['name'],
                ['Role1'],
                ['Role2'],
                ['Role3'],
            ],
        ],
    },
};
