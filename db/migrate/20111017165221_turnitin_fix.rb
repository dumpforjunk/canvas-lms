class TurnitinFix < ActiveRecord::Migration
  def self.up
    Assignment.record_timestamps = false
    Assignment.find_each(:conditions => "turnitin_enabled AND EXISTS (SELECT 1 FROM submissions WHERE assignment_id = assignments.id AND turnitin_data IS NOT NULL)") do |assignment|
      assignment.turnitin_settings = assignment.turnitin_settings
      assignment.turnitin_settings[:created] = true
      assignment.save
    end
    Assignment.record_timestamps = true
  end

  def self.down
  end
end
