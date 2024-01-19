namespace :backup do
    desc 'Back up the database'
    
    task :perform do
        puts "Starting backup of #{Rails.env} environment"
        db_source_path = 'db/development.sqlite3'
        db_backup_path = 'backup/development_backup.sqlite3'

        uploads_source_path = 'public/uploads'
        uploads_backup_path = 'backup/uploads'

        # create the directory backup, if dont exist
        FileUtils.mkdir_p('backup')

        # copy the DB file to the backup folder
        FileUtils.cp(db_source_path, db_backup_path)

        # copy of uploads directory
        FileUtils.cp_r(uploads_source_path, uploads_backup_path, presence: true)

        # time of created backup
        timestamp       = Time.now.strftime('%Y-%m-%d')
        
        # command rake backup:perform
        puts 'Backup test'
    end
end