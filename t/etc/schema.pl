{
    'schema_class' => 'Lecstor::Schema',
    'connect_opts' => {
        name_sep => '.',
        quote_char => '`',
        mysql_enable_utf8 => '1',
    },

    'traits' => [qw!Testmysqld!],
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
