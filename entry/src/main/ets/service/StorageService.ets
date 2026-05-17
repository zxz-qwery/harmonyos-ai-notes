import preferences from '@ohos.data.preferences'
import type { Note } from '../model/NoteModel'

const STORE_NAME: string = 'ai_notes_store'
const NOTES_KEY: string = 'notes'

export default class StorageService {
  private prefs: preferences.Preferences | null = null
  private readonly context: Context

  constructor(context: Context) {
    this.context = context
  }

  private async getPrefs(): Promise<preferences.Preferences> {
    if (this.prefs) {
      return this.prefs
    }
    this.prefs = await preferences.getPreferences(this.context, STORE_NAME)
    return this.prefs
  }

  async saveNotes(notes: Note[]): Promise<void> {
    const prefs = await this.getPrefs()
    await prefs.put(NOTES_KEY, JSON.stringify(notes))
    await prefs.flush()
  }

  async getNotes(): Promise<Note[]> {
    const prefs = await this.getPrefs()
    const raw: string = (await prefs.get(NOTES_KEY, '[]')) as string
    const text = typeof raw === 'string' ? raw : String(raw)

    try {
      const data: Note[] = JSON.parse(text) as Note[]
      return Array.isArray(data) ? data : []
    } catch (_) {
      return []
    }
  }

  async deleteNote(id: string): Promise<void> {
    const notes = await this.getNotes()
    const next = notes.filter(item => item.id !== id)
    await this.saveNotes(next)
  }
}
