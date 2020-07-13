component {

    function up( schema, query ) {
        queryExecute( "
            CREATE TABLE `bumps` (
                `userId` INTEGER UNSIGNED NOT NULL,
                `rantId` INTEGER UNSIGNED NOT NULL,
                CONSTRAINT `pk_bumps`
                    PRIMARY KEY (`userId`, `rantId`),
                CONSTRAINT `fk_bumps_userId`
                    FOREIGN KEY (`userId`)
                    REFERENCES `users` (`id`)
                    ON UPDATE CASCADE
                    ON DELETE CASCADE,
                CONSTRAINT `fk_bumps_rantId`
                    FOREIGN KEY (`rantId`)
                    REFERENCES `rants` (`id`)
                    ON UPDATE CASCADE
                    ON DELETE CASCADE
            )
        " );
    }

    function down( schema, query ) {
        queryExecute( "DROP TABLE `bumps`" );
    }

}
