require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe WholesalerObserver do
  it "should reset due dates for all wholesaler tasks if the wholesaler event date is updated" do 
    mock_wholesaler = mock_model(Wholesaler, :event_date_changed? => true)
    mock_wholesaler.should_receive(:reset_task_due_dates!)
    WholesalerObserver.instance.after_update(mock_wholesaler)
  end

  it "should not reset due dates for wholesaler tasks if the wholesaler event date is not updated" do
    mock_wholesaler = mock_model(Wholesaler, :event_date_changed? => false)
    mock_wholesaler.should_not_receive(:reset_task_due_dates!)
    WholesalerObserver.instance.after_update(mock_wholesaler)
  end
end
