import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ToppostsComponent } from './topposts.component';

describe('ToppostsComponent', () => {
  let component: ToppostsComponent;
  let fixture: ComponentFixture<ToppostsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ToppostsComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(ToppostsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
