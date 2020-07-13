component {

    function up( schema, query ) {
        queryExecute( "
            CREATE TABLE `poops` (
                `userId` INTEGER UNSIGNED NOT NULL,
                `rantId` INTEGER UNSIGNED NOT NULL,
                CONSTRAINT `pk_poops`
                    PRIMARY KEY (`userId`, `rantId`),
                CONSTRAINT `fk_poops_userId`
                    FOREIGN KEY (`userId`)
                    REFERENCES `users` (`id`)
                    ON UPDATE CASCADE
                    ON DELETE CASCADE,
                CONSTRAINT `fk_poops_rantId`
                    FOREIGN KEY (`rantId`)
                    REFERENCES `rants` (`id`)
                    ON UPDATE CASCADE
                    ON DELETE CASCADE
            )
        " );
    }

    function down( schema, query ) {
        queryExecute( "DROP TABLE `poops`" );
    }

}
