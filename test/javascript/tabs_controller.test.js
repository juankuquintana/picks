import TabsController from 'tabs_controller';
import { Application } from '@hotwired/stimulus';
import { screen } from '@testing-library/dom';

describe('TabsController', () => {
  beforeAll(() => {
    window.Stimulus = Application.start();
    Stimulus.register('tabs', TabsController);
  });

  beforeEach(() => {
    document.body.innerHTML = `
      <div data-controller='tabs' data-tabs-default-tab-value='tab1' class='mb-4'>
        <ul class='flex flex-wrap -mb-px text-sm font-medium text-center border-b border-gray-200' role='tablist'>
          <li class='me-2' role='presentation'>
            <button id='tab1' data-tabs-target='btn' data-action='click->tabs#select' class='inline-block p-4 rounded-t-lg'>
              Tab 1
            </button>
            <button id='tab2' data-tabs-target='btn' data-action='click->tabs#select' class='inline-block p-4 rounded-t-lg'>
              Tab 2
            </button>
          </li>
        </ul>
        <div>
          <div data-tabs-target='tab' id='tab1'>
            Tab 1 content
          </div>
          <div data-tabs-target='tab' id='tab2'>
            Tab 2 content
          </div>
        </div>
      </div>
    `;
  });

  it('shows default tab', () => {
    const el = document.querySelector('[data-controller="tabs"]');
    expect(el).toHaveTextContent('Tab 1 content');
  });

  it('changes tab', async () => {
    const tab2 = screen.getByText('Tab 2');
    await tab2.click();

    const el = document.querySelector('[data-controller="tabs"]');
    expect(el).toHaveTextContent('Tab 2 content');
  });
});
