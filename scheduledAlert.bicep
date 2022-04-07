resource view 'Microsoft.CostManagement/views@2021-10-01' existing={
    name:'gaag-billingoverview'
}


resource scheduledalert 'Microsoft.CostManagement/scheduledActions@2020-03-01-preview' = {
  name: 'resourceName'
  properties:{
    displayName: 'Cost view schedule'
    status: 'enabled'
    kind: 'Email'
    viewId: view.id
        schedule: {
            frequency: 'Weekly'
            hourOfDay: '1'
            daysOfWeek: [
                'Monday'
                'Tuesday'
                'Wednesday'
                'Thursday'
                'Friday'
            ]
            startdate: '2021-09-09T06:00:00Z'
            endDate: '2022-09-09T06:00:00Z'
        }
        notification: {
            to: [
        'maik@familie-vandergaag.nl'
            ]
            subject: 'test'
        }
  }
}
