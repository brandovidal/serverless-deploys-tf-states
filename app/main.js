console.log('hello world init')

export async function handler (event) {
  console.log({ event })
  const data = { message: 'Your function executed successfully!' }

  return {
    statusCode: 200,
    headers: {
      'Access-Control-Allow-Origin': '*'
    },
    body: JSON.stringify(data, null, 2)
  }
}
